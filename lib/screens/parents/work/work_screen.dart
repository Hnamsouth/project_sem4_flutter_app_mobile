import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

List<List<String>> imageLists = [
  [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScXcCBr_h6zpmV83U6vnDdN-2oBOzSodtlAA&s",
        "https://file3.qdnd.vn/data/images/0/2023/05/03/vuhuyen/khanhphan.jpg?dpi=150&quality=100&w=870",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPPI7duriAdrW4WsFhgqEMLkOVwdbNf9Wg7Q&s",
    "data:image/jpeg;base64,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"
  ],

];

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Hoạt động'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.edit),
                  hintText: 'Hãy chia sẻ hoạt động của bạn...',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(width: 0, color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.image,
                      color: Colors.blueAccent,
                    ),
                    label:
                        Text('Đăng ảnh', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      // Handle image upload
                    },
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(width: 0, color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.videocam,
                      color: Colors.pinkAccent,
                    ),
                    label: Text('Đăng video',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      // Handle video upload
                    },
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(width: 0, color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.wallpaper,
                      color: Colors.cyan,
                    ),
                    label:
                        Text('Hình nền', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      // Handle background change
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: imageLists.length,
                itemBuilder: (context, index) {
                  return _buildHeader(
                    "name",
                    "role",
                    "2024-06-09",
                    "Tiếp nối thành công của lần cập nhật trước, nhằm hỗ trợ Thầy Cô và cha mẹ học sinh chia sẻ những khoảnh khắc đáng nhớ của các con trong quá trình học tập, vui chơi tại trường cũng như ở nhà, eNetViet tiếp tục nâng cấp và hoàn thiện tính năng đăng “Hoạt động” để làm cầu nối mang cả trường học về Nhà",
                    imageLists[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(String name, String role, String createAt, String content,
    List<String> imageUrls) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    color: Colors.white,
    child: Column(children: [
      ListTile(
        title: Text(name),
        subtitle: Text(role),
        leading: CircleAvatar(
          child: Text("A"),
        ),
        trailing: Text(createAt),
        // trailing:Text(DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(createAt)) ,
      ),
      SizedBox(
        height: 10,
      ),
      Text(content),
      SizedBox(
        height: 10,
      ),
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: imageUrls.length == 1 ? 1 : 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          String imageUrl = imageUrls[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: imageUrl.startsWith('http')
                ? Image.network(imageUrl, fit: BoxFit.cover)
                : Image.memory(base64Decode(imageUrl.split(',')[1]),
                    fit: BoxFit.cover),
          );
        },
      ),
      SizedBox(height: 20,child: Container(color: Colors.white60,),)
    ]
    ),
  );
}
