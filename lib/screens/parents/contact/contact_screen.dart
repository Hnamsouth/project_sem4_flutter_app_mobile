import 'package:flutter/material.dart';

import '../../../model/parent_model.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';



class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
 _ContactScreenState createState() => _ContactScreenState();
  }

  class _ContactScreenState extends State<ContactScreen>{

    List<ParentDetails> _searchResult = [];
    List<ParentDetails> _parentDetails = [];
    TextEditingController controller =  TextEditingController();


    Future<Null> getUserDetails() async {
      const String url = 'https://jsonplaceholder.typicode.com/users';

      final dio =Dio();
      final response = await dio.get(url);
      // print(response.data);
      setState(() {
        for (Map<dynamic,dynamic> user in response.data) {
          _parentDetails.add(ParentDetails.fromJson(user));
        }
      });
    }
    @override
    void initState() {
      super.initState();

      getUserDetails();
    }


    Widget _buildUsersList() {
      return  ListView.builder(
        itemCount: _parentDetails.length,
        itemBuilder: (context, index) {
          return  Card(
            color: Colors.white,
            child:
            Column(
              children:[
              ListTile(
                leading:  CircleAvatar(
                  backgroundImage:  NetworkImage(
                    _parentDetails[index].profileUrl!,
                  ),
                ),
                title:  Text(_parentDetails[index].firstName! +
                    ' ' +
                    _parentDetails[index].lastName!,style: TextStyle(
                  color: Colors.black
                )),
                subtitle: Text(
                  'Phone: ' + _parentDetails[index].phone!,style: TextStyle(
                  color: Colors.black
                ),),
              ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Call'),
                      onPressed: () => launch(_parentDetails[index].phone!),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('Chat'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
             ]
            ),
          );
        },
      );
    }

    Widget _buildSearchResults() {
      return  ListView.builder(
        itemCount: _searchResult.length,
        itemBuilder: (context, i) {
          return  Card(
            color: Colors.white,
            child:  ListTile(
              leading:  CircleAvatar(
                backgroundImage:  NetworkImage(
                  _searchResult[i].profileUrl!,
                ),
              ),
              title:  Text(
                style: TextStyle(
                  color: Colors.black,
                ),
                  _searchResult[i].firstName! + ' ' +_searchResult[i].lastName!),


            ),
            margin: const EdgeInsets.all(0.0),
          );
        },
      );
    }

    Widget _buildSearchBox() {
      return  Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Card(
          color: Colors.white,

          child:  ListTile(
            leading:  Icon(Icons.search,color: Colors.black,),
            title:  TextField(

                style: TextStyle(
                color: Colors.black
              ),
              controller: controller,
              decoration:  const InputDecoration(
                  hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,),
              onChanged: onSearchTextChanged,
            ),
            trailing:  IconButton(
              icon:  const Icon(Icons.cancel,color: Colors.black,),
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
      return  Column(
        children: <Widget>[
           Container(
              color: Colors.white, child: _buildSearchBox()),
           Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? _buildSearchResults()
                  : _buildUsersList()),
        ],
      );
    }




    @override
  Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: DefaultTabController(
  //       length: 2,
  //       child: Scaffold(
  //         appBar: AppBar(
  //           title: Text("Danh bạ"),
  //           bottom: const TabBar(
  //             tabs: [
  //               Tab(
  //                 child: Text(
  //                   "Giáo Viên",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 20),
  //                 ),
  //               ),
  //               Tab(
  //                 child: Text(
  //                   "Phụ Huynh",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 20),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         body: TabBarView(
  //           children: [
  //             ListView.builder(
  //                 padding: const EdgeInsets.all(8),
  //                 itemCount: entries.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return Container(
  //                     height: 50,
  //                     color: Colors.amber[colorCodes[index]],
  //                     child: Center(child: Text(' ${entries[index]}')),
  //                   );
  //                 }),
  //             Icon(Icons.directions_bike),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

      return  Scaffold(
        appBar:  AppBar(
automaticallyImplyLeading: false,          title:  Text('Danh Bạ'),
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

      _parentDetails.forEach((userDetail) {
        if (userDetail.firstName!.contains(text) ||
            userDetail.lastName!.contains(text)) _searchResult.add(userDetail);
      });

      setState(() {});
    }


}


