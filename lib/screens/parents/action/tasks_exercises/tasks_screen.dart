import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/model/student/homework_model.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tasks_exercises/homework_detail_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tasks_exercises/submit-details.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tasks_exercises/task_submit.dart';
import 'package:project_sem4_flutter_app_mobile/screens/widgets/build_searchbox.dart';
import 'package:project_sem4_flutter_app_mobile/service/homework_service.dart';
import 'package:intl/intl.dart' as intl;

final StudentController studentController = Get.find();
final _id = studentController.studentRecord.value.students!.id;

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController textEditingController;

  final HomeWorkService homeWorkService = HomeWorkService();
  late Future<List<HomeWorkModel>> _homeworkFuture;

  @override
  void initState() {
    super.initState();
    _homeworkFuture = homeWorkService.getAllHomeWork(_id);

    _tabController = TabController(length: 2, vsync: this);
    textEditingController =
        TextEditingController(); // Initialize the TextEditingController
  }

  @override
  void dispose() {
    _tabController.dispose();
    textEditingController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nhiệm vụ, Bài tập",
          style: TextStyle(fontSize: 20),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "ĐÃ GIAO",
            ),
            Tab(text: "ĐÃ HOÀN THÀNH"),
          ],
          labelStyle:
              TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildDelivered(), _buildCompleted()],
      ),
    );
  }

  Widget _buildDelivered() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            FutureBuilder<List<HomeWorkModel>>(
              future: _homeworkFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No homework data availabl');
                } else {
                  List<HomeWorkModel> filteredHomework = snapshot.data!
                      .where(
                          (homework) => homework.studentYearHomeWorks == null)
                      .toList();

                  if (filteredHomework.isEmpty) {
                    return Text('Không có bài tập chưa hoàn thành !!!');
                  }

                  return Column(
                    children: filteredHomework.map((homework) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(HomeworkDetailsScreen(
                              id: homework.id,
                              studentYearHomeWorks:
                                  homework.studentYearHomeWorks,
                              teacherName: homework.teacherInfo?.fullName,
                              content: homework.content,
                              homeworkImageUrls: homework.homeworkImageUrls,
                              dueDate: homework.dueDate,
                              subject: homework.subject?.name));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.account_box_outlined),
                                  title: RichText(
                                    text: TextSpan(
                                      text: "Giáo viên : ",
                                      style: TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              homework.teacherInfo?.fullName ??
                                                  '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            decorationStyle:
                                                TextDecorationStyle.wavy,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: RichText(
                                    text: TextSpan(
                                      text: "Môn học : ",
                                      style: TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: homework.subject?.name ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            decorationStyle:
                                                TextDecorationStyle.wavy,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Đề bài : ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: homework.content!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        text: "Hạn nộp : ",
                                        style: TextStyle(
                                            color: DateTime.now()
                                                    .isAfter(homework.dueDate!)
                                                ? Colors.red
                                                : Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: intl.DateFormat(
                                                    'EEEE, dd/MM/yyyy', 'vi_VN')
                                                .format(homework.dueDate!),
                                            style: TextStyle(
                                              color: DateTime.now().isAfter(
                                                      homework.dueDate!)
                                                  ? Colors.red
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                          backgroundColor: DateTime.now()
                                                  .isAfter(homework.dueDate!)
                                              ? MaterialStateProperty.all(
                                                  Colors.red)
                                              : MaterialStateProperty.all(
                                                  Colors.blueAccent)),
                                      child: Text(
                                        DateTime.now()
                                                .isAfter(homework.dueDate!)
                                            ? 'Quá hạn'
                                            : "Nộp bài",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        DateTime.now()
                                                .isAfter(homework.dueDate!)
                                            ? null
                                            : Get.to(TaskSubmissionScreen(
                                                id: homework.id!,
                                              ));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompleted() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            FutureBuilder<List<HomeWorkModel>>(
              future: _homeworkFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No homework data available');
                } else {
                  List<HomeWorkModel> filteredHomework = snapshot.data!
                      .where(
                          (homework) => homework.studentYearHomeWorks != null)
                      .toList();

                  if (filteredHomework.isEmpty) {
                    return Text('Không có bài tập chưa hoàn thành !!!');
                  }

                  return Column(
                    children: filteredHomework.map((homework) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(HomeworkDetailsScreen(
                              id: homework.id,
                              studentYearHomeWorks:
                                  homework.studentYearHomeWorks,
                              teacherName: homework.teacherInfo?.fullName,
                              content: homework.content,
                              homeworkImageUrls: homework.homeworkImageUrls,
                              dueDate: homework.dueDate,
                              subject: homework.subject?.name));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.account_box_outlined),
                                  title: RichText(
                                    text: TextSpan(
                                      text: "Giáo viên : ",
                                      style: TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              homework.teacherInfo?.fullName ??
                                                  '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            decorationStyle:
                                                TextDecorationStyle.wavy,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: RichText(
                                    text: TextSpan(
                                      text: "Môn học : ",
                                      style: TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: homework.subject?.name ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            decorationStyle:
                                                TextDecorationStyle.wavy,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Đề bài : ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: homework.content!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    RichText(

                                      text: TextSpan(

                                        text: "Hạn nộp : ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: DateTime.now()
                                                .isAfter(homework.dueDate!)
                                                ? Colors.red
                                                : Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: intl.DateFormat(
                                                'EEEE, dd/MM/yyyy', 'vi_VN')
                                                .format(homework.dueDate!),
                                            style: TextStyle(
                                              color: DateTime.now().isAfter(
                                                  homework.dueDate!)
                                                  ? Colors.red
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              decorationStyle:
                                              TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(

                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blueAccent)),
                                      child: Text(
                                        'Chi tiết bài làm ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Get.to(SubmitDetailsScreen(
                                          id: homework.id!,
                                          dueDate: homework.dueDate!,
                                          studentYearHomeWorks:
                                          homework.studentYearHomeWorks,
                                        ));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}








