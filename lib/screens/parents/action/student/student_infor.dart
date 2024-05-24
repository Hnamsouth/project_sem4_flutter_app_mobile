import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_sem4_flutter_app_mobile/model/student_info.dart';
import 'package:project_sem4_flutter_app_mobile/service/student_service.dart';

import '../../../../controller/student_controller.dart';
import '../../../../controller/user_controller.dart';

final UserController ctrl = Get.find();
final int? id = ctrl.user.value.id;


final StudentController ctrl2 = Get.find();

class StudentInfoScreen extends StatefulWidget {
  const StudentInfoScreen({super.key});


  @override
  State<StudentInfoScreen> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfoScreen> with TickerProviderStateMixin {
  final StudentController ctrl2 = Get.find();

  late TabController _tabController;
  Future<StudentRecord>? _studentRecordFuture;


  @override
  void initState() {
    super.initState();
    _studentRecordFuture = getInfo();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<StudentRecord> getInfo() async {
    var student = await StudentService.getOne(id!);
    ctrl2.setStudentRecord(student);
    return student;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin học sinh'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'THÔNG TIN', icon: Icon(Icons.info)),
            Tab(text: 'SỨC KHỎE', icon: Icon(Icons.health_and_safety)),
            Tab(text: 'LIÊN HỆ', icon: Icon(Icons.contact_phone)),
          ],
        ),
      ),
      body: FutureBuilder<StudentRecord>(
        future: _studentRecordFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildInfoTab(snapshot.data!),
                _buildHealthTab(),
                _buildContactTab(),
              ],
            );
          } else {
            return Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }

  Widget _buildInfoTab(StudentRecord studentRecord) {
    final student = studentRecord.students;
    final schoolYearClass = studentRecord.schoolYearClass;

    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                // backgroundImage: NetworkImage(student.studentStatuses.first.status.color ?? ''),
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 10),
              Text('${student?.firstName} ${student?.lastName}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 20),
        _buildInfoRow('Mã số', student!.studentCode),
        _buildInfoRow('Họ và tên', '${student.firstName} ${student.lastName}'),
        _buildInfoRow('Ngày sinh', student.birthday.toIso8601String().substring(0, 10)),
        _buildInfoRow('CMND/CCCD', ''),
        _buildInfoRow('Nơi cấp', ''),
        _buildInfoRow('Ngày cấp', ''),
        _buildInfoRow('Giới tính', student.gender ? 'Nam' : 'Nữ'),
        _buildInfoRow('Lớp', schoolYearClass!.className),
        _buildInfoRow('Năm học', '${schoolYearClass.schoolYear.startSem1.year} - ${schoolYearClass.schoolYear.end.year}'),
        _buildInfoRow('Dân tộc', 'Kinh'),
        _buildInfoRow('Địa chỉ', student.address),
      ],
    );
  }

  Widget _buildHealthTab() {
    // Build the health tab content here
    return Center(child: Text('${ctrl2.studentRecord.value.id}'));
  }

  Widget _buildContactTab() {
    // Build the contact tab content here
    return Center(child: Text('Chưa có dữ liệu'));
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: TextStyle(fontSize: 16)),
          ),
          if (title == 'CMND/CCCD' || title == 'Nơi cấp' || title == 'Ngày cấp')
            IconButton(
              icon: Icon(Icons.edit, size: 16),
              onPressed: () {
                // Handle edit action
              },
            ),
        ],
      ),
    );
  }
}
