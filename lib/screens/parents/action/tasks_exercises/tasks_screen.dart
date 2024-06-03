import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tasks_exercises/task_submit.dart';
import 'package:project_sem4_flutter_app_mobile/screens/widgets/build_searchbox.dart';

final StudentController studentController = Get.find();

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
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
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(text: "ĐÃ GIAO",),
          Tab(text: "ĐÃ HOÀN THÀNH"),

        ],labelStyle: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold
        ),
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    title: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm',
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                      onChanged: null,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Card(



                child:
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.account_box_outlined),
                        title: Text('Giáo viên : '),
                        subtitle:
                            Text('GVCN : Ngữ Văn - Lớp 1A'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Hạn nôp :"),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent),
                            ),
                            child: const Text(
                              'Nộp bài',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Get.to(TaskSubmissionScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCompleted() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.black,
              ),
              title: TextField(
                style: TextStyle(color: Colors.black),
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                onChanged: null,
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.black,
                ),
                onPressed: () {
                  textEditingController.clear();
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
