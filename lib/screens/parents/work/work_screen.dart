import 'package:flutter/material.dart';

class WorkScreen extends StatelessWidget{
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Hoạt động'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(

                  hintText: 'Hãy chia sẻ hoạt động của bạn...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.image,color: Colors.black,),
                  label: Text('Đăng ảnh',style: TextStyle(
                    color: Colors.black)),
                  onPressed: () {
                    // Handle image upload
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.videocam,color: Colors.black,),
                  label: Text('Đăng video',style: TextStyle(
                      color: Colors.black)),
                  onPressed: () {
                    // Handle video upload
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.wallpaper,color: Colors.black,),
                  label: Text('Hình nền',style: TextStyle(
                      color: Colors.black)),
                  onPressed: () {
                    // Handle background change
                  },
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insert_drive_file, size: 50),
                    Text('Chưa có dữ liệu.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





