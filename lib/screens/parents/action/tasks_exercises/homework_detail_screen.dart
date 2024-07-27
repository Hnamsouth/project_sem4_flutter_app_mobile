import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart' as path;

import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tasks_exercises/task_submit.dart';

import '../../../../model/student/student_year_homework.dart';

class HomeworkDetailsScreen extends StatefulWidget {
  final int? id;
  final String? teacherName;
  final String? content;

  final List<String>? homeworkImageUrls;
  final List<StudentYearHomeWorks>? studentYearHomeWorks;

  final DateTime? dueDate;
  final String? subject;

  const HomeworkDetailsScreen(
      {super.key,
      required this.id,
      required this.teacherName,
      required this.content,
      required this.dueDate,
      required this.subject,
      this.homeworkImageUrls,
      this.studentYearHomeWorks});

  @override
  State<HomeworkDetailsScreen> createState() => _HomeworkDetailsScreenState();
}

class _HomeworkDetailsScreenState extends State<HomeworkDetailsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingControllerHw =
      TextEditingController();

  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _saveImage(String imageUrl) async {
    try {
      Dio dio = Dio();
      String fileName = path.basename(imageUrl);
      String savePath = (await _getLocalPath()) + '/' + fileName;
      await dio.download(imageUrl, savePath);
      print('Image saved to $savePath');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image saved to $savePath'),
      ));
    } catch (e) {
      print('Error saving image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save image'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = widget.content!;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            child: Text(
              DateTime.now().isAfter(widget.dueDate!)
                  ? 'Hết hạn nộp'
                  : 'Nộp lại',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              DateTime.now().isAfter(widget.dueDate!)
                  ? null
                  : Get.to(TaskSubmissionScreen(
                      id: widget.id!,
                    ));
            },
          ),
        ],
        title: Text("Chi tiết bài tập"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.only(bottom: 15),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: RichText(
                  text: TextSpan(
                    text: "Môn học: ",
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.subject!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    text: "Hạn nộp: ",
                    style: TextStyle(
                        color: DateTime.now().isAfter(widget.dueDate!)
                            ? Colors.red
                            : Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: intl.DateFormat('EEEE, dd/MM/yyyy', 'vi_VN')
                            .format(widget.dueDate!),
                        style: TextStyle(
                          color: DateTime.now().isAfter(widget.dueDate!)
                              ? Colors.red
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Đề bài:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: _textEditingController,
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                maxLines: 3,
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(height: 20),


            Text(
              'Ảnh đính kèm :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),

            widget.homeworkImageUrls != null && widget.homeworkImageUrls!.isNotEmpty
                ? GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: widget.homeworkImageUrls!.length,
              itemBuilder: (context, index) {
                String imageUrl = widget.homeworkImageUrls![index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: PhotoView(
                          imageProvider: NetworkImage(imageUrl),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            )
                : Container(child: Text("Không có ảnh đính kèm"),),
          ],
        ),
      ),
    );
  }
}




