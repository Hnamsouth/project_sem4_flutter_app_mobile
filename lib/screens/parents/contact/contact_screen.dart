import 'package:flutter/material.dart';

import '../../../model/parent_model.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<TeacherContact> _searchResult = [];
  List<TeacherContact> _teacherDetails = [];
  TextEditingController controller = TextEditingController();

  Future<Null> getUserDetails() async {
    const String url =
        'http://14.248.97.203:4869/api/v1/teacher/teacher-contact?schoolYearClassId=1';

    final dio = Dio();
    final response = await dio.get(url);
    print(response.data);
    setState(() {
      for (Map<String, dynamic> user in response.data) {
        _teacherDetails.add(TeacherContact.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  Widget _buildUsersList() {
    return ListView.builder(
      itemCount: _teacherDetails.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: Column(children: [
            ListTile(
              title: Text(_teacherDetails[index].name!,
                  style: TextStyle(color: Colors.black)),
              subtitle: Text(
                'Mon: ' + _teacherDetails[index].subjects!.join(", "),

              ),
              textColor: Colors.black,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Call'),
                  onPressed: () => launch(_teacherDetails[index].phone!),
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Chat'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ]),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        return Card(
          color: Colors.white,
          child: ListTile(
            title: Text(
                style: TextStyle(
                  color: Colors.black,
                ),
                _searchResult[i].name!),
          ),
          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            Icons.search,
            color: Colors.black,
          ),
          title: TextField(
            style: TextStyle(color: Colors.black),
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
            ),
            onChanged: onSearchTextChanged,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.black,
            ),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(color: Colors.white, child: _buildSearchBox()),
        Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildUsersList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Danh Bạ'),
        elevation: 0.0,
      ),
      body: _buildBody(),
      // resizeToAvoidBottomInset: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var userDetail in _teacherDetails) {
      if (userDetail.name!.contains(text)) _searchResult.add(userDetail);
    }

    setState(() {});
  }
}
