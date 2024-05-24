import 'dart:io'; // Thay thế 'dart:html' bằng 'dart:io'

import 'package:dio/dio.dart' as dio; // Đổi tên thư viện dio khi nhập
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_sem4_flutter_app_mobile/screens/test/example.dart';

class TaskSubmissionScreen extends StatefulWidget {
  @override
  _TaskSubmissionScreenState createState() => _TaskSubmissionScreenState();
}

class _TaskSubmissionScreenState extends State<TaskSubmissionScreen> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  List<File> _images = [];
  final picker = ImagePicker();
  final dio.Dio _dio = dio.Dio();

  Future<void> _pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    } else {
      print('No images selected.');
    }
  }

  Future<void> _uploadImages() async {
    if (_images.isEmpty) return;

    try {
      List<dio.MultipartFile> multipartImages = [];
      for (var image in _images) {
        String fileName = image.path.split('/').last;
        multipartImages.add(await dio.MultipartFile.fromFile(image.path, filename: fileName));
      }

      dio.FormData formData = dio.FormData.fromMap({
        "images": multipartImages,
      });

      dio.Response response = await _dio.post(
        'https://your-server.com/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Images uploaded successfully!');
      } else {
        print('Image upload failed!');
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soạn nội dung bài làm'),
        actions: [
          TextButton(
            onPressed: _uploadImages,
            child: const Text(
              'Nộp bài',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Text('D'), // Initial of the user's name
              ),
              title: Text('Nguyễn Thị Thùy Dương'),
              subtitle: Text('P/h em: Nguyễn Minh Khôi'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _textController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Soạn nội dung bài làm...',
                border: InputBorder.none,
              ),
            ),
            _images.isEmpty
                ? Text('')
                : Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _images.map((image) => Image.file(image, width: 100, height: 100)).toList(),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: _pickImages,
                    icon: Icon(Icons.image, color: Colors.blue),
                    label: Text('Hình ảnh', style: TextStyle(color: Colors.blue)),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Handle file attachment
                    },
                    icon: Icon(Icons.attach_file, color: Colors.blue),
                    label: Text('Tệp đính kèm', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
