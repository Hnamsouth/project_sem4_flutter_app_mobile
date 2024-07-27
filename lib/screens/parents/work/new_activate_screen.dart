import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/student_controller.dart';


final StudentController studentController = Get.find();

class NewActivateScreen extends StatefulWidget {
  final int id;
  final String name;

  const NewActivateScreen({super.key, required this.id, required this.name});

  @override
  State<NewActivateScreen> createState() => _NewActivateScreenState();
}

class _NewActivateScreenState extends State<NewActivateScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tạo bài viết'),
        actions: [
          TextButton(
            onPressed: () {
              // Handle post action
            },
            child: Text(
              'Đăng',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
             backgroundImage : AssetImage('assets/images/app-icon.png'), // Add your profile image here
            ),
            title: Text(widget.name),
            subtitle: Text('Lớp 3A'),

          ),

          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Hãy chia sẻ hoạt động của bạn...',
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
              color: Colors.white,
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.all( 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.photo, 'Đăng ảnh'),
                  _buildActionButton(Icons.video_call, 'Đăng video'),
                  _buildActionButton(Icons.wallpaper, 'Hình nền'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }

}





