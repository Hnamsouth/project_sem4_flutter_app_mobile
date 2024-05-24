import 'dart:io'; // Thay đổi từ 'dart:html' sang 'dart:io'

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  List<File> _images = [];
  final picker = ImagePicker();
  final Dio _dio = Dio();

  Future<void> _pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    setState(() {
      _images = pickedFiles.map((file) => File(file.path)).toList();
        });
  }

  Future<void> _uploadImages() async {
    if (_images.isEmpty) return;

    try {
      List<MultipartFile> multipartImages = [];
      for (var image in _images) {
        String fileName = image.path.split('/').last;
        multipartImages.add(await MultipartFile.fromFile(image.path, filename: fileName));
      }

      FormData formData = FormData.fromMap({
        "images": multipartImages,
      });

      Response response = await _dio.post(
        'https://your-server.com/upload', // Thay URL bằng URL server của bạn
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
        title: Text('Upload Images Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _images.isEmpty
                ? Text('No images selected.')
                : Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _images.map((image) => Image.file(image, width: 100, height: 100)).toList(),
            ),
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Pick Images'),
            ),
            ElevatedButton(
              onPressed: _uploadImages,
              child: Text('Upload Images'),
            ),
          ],
        ),
      ),
    );
  }
}
