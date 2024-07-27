import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tasks_exercises/task_submit.dart';
import '../../../../model/student/student_year_homework.dart';

class SubmitDetailsScreen extends StatefulWidget {
  final DateTime? dueDate;
  final int? id;
  final List<StudentYearHomeWorks>? studentYearHomeWorks;

  const SubmitDetailsScreen(
      {Key? key, this.studentYearHomeWorks, this.dueDate, this.id})
      : super(key: key);

  @override
  _SubmitDetailsScreenState createState() => _SubmitDetailsScreenState();
}

class _SubmitDetailsScreenState extends State<SubmitDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(

            child: Text(
              DateTime.now().isAfter(widget.dueDate!) ? 'Hết hạn' : 'Nộp lại',
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
        title: Text("Chi tiết bài làm"),
      ),
      body: widget.studentYearHomeWorks != null
          ? SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [





            Text(
              'Nội dung bài làm :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Text(
                widget.studentYearHomeWorks!.first.description!,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ảnh đính kèm :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount:
              widget.studentYearHomeWorks!.first.imageUrl?.length ?? 0,
              itemBuilder: (context, index) {
                String? imageUrl =
                widget.studentYearHomeWorks!.first.imageUrl![index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: PhotoView(
                          imageProvider: NetworkImage(imageUrl!),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
