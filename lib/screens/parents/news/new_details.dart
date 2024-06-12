import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewDetails extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final String content;

  const NewDetails(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.content,
      super.key});

  @override
  State<NewDetails> createState() => _NewDetailsState();
}

class _NewDetailsState extends State<NewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                Text(widget.title),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("This is Title",style: TextStyle(fontSize: 20),),
              subtitle:   Text("This is subtitle"),
            ),

            SizedBox(
              height: 15,
            ),
            Image.network(widget.imageUrl),
            SizedBox(
              height: 10,
            ),
            Text(widget.content)
          ],
        ),
      ),
    );
  }
}
