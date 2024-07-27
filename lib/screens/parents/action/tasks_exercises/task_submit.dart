


import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img; // Add the 'image' package
import 'package:image_picker/image_picker.dart';
import 'package:project_sem4_flutter_app_mobile/service/api_service.dart';

import '../../../../controller/student_controller.dart';
import '../../../../controller/user_controller.dart';

final UserController ctrl = Get.find();
final StudentController studentController = Get.find();

class TaskSubmissionScreen extends StatefulWidget {
  final int id;

  const TaskSubmissionScreen({super.key, required this.id});

  @override
  _TaskSubmissionScreenState createState() => _TaskSubmissionScreenState();
}

class _TaskSubmissionScreenState extends State<TaskSubmissionScreen> {
  late TextEditingController _descriptionController;
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    } else {
      print('No images selected.');
    }
  }

  Future<File> _convertHeicToJpg(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    final jpgBytes = img.encodeJpg(image!);
    final jpgFile = File('${file.path}.jpg');
    await jpgFile.writeAsBytes(jpgBytes);
    return jpgFile;
  }

  Future<void> _uploadImages() async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    if (_images.isEmpty) return;

    try {
      List<dio.MultipartFile> multipartImages = [];
      for (var image in _images) {
        if (image.path.toLowerCase().endsWith('.heic')) {
          image = await _convertHeicToJpg(image);
        }
        String fileName = image.path.split('/').last;
        multipartImages.add(
            await dio.MultipartFile.fromFile(image.path, filename: fileName));
      }

      dio.FormData formData = dio.FormData.fromMap({
        "images": multipartImages,
        "description": _descriptionController.text,
        "studentYearInfoId": studentController.studentRecord.value.id,
        "homeWorkId": widget.id,
      });

      final response = await DioService().post2(
          '/createStudentHomeWork',
          data: formData,
          options: dio.Options(headers: {
            "Authorization": "Bearer ${ctrl.user.value.authResponse?.token}"
          }));

      EasyLoading.dismiss();

      if (response.statusCode == 201) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Thông báo'),
            content: const Text('Nộp bài thành công !!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/home_parent'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Image upload failed! Status code: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      if (e is dio.DioException) {
        print('Dio error: ${e.message}');
        print('Error details: ${e.response?.data}');
      } else {
        print('Error uploading images: $e');
      }
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
              title: Text(ctrl.user.value.userDetail?.fullName()),
              subtitle: Text(
                  'P/h em: ${studentController.studentRecord.value.students?.getFullName()}'),
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.text,
              controller: _descriptionController,
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
              children: _images
                  .map((image) =>
                  Image.file(image, width: 100, height: 100))
                  .toList(),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: _pickImages,
                    icon: Icon(Icons.image, color: Colors.blue),
                    label:
                    Text('Hình ảnh', style: TextStyle(color: Colors.blue)),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Handle file attachment
                    },
                    icon: Icon(Icons.attach_file, color: Colors.blue),
                    label: Text('Tệp đính kèm',
                        style: TextStyle(color: Colors.blue)),
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

