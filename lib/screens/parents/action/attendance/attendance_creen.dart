import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/model/attendance_model.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/attendance/take_leave.dart';
import 'package:project_sem4_flutter_app_mobile/service/attendance_service.dart';

final StudentController studentController = Get.find();

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<AttendanceList>> futureAttendance;
  final List<DateTime> _recentDates = List.generate(30, (index) => DateTime.now().subtract(Duration(days: index)));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    initializeDateFormatting('vi_VN', null).then((_) {
      setState(() {});
    });
    futureAttendance = getAttendances();
  }

  Future<List<AttendanceList>> getAttendances() async {
    final data = await AttendanceService.getAttendance(studentController.studentRecord.value.students!.id);
    return data.map<AttendanceList>((json) => AttendanceList.fromJson(json)).toList();
  }

  String _getAttendanceStatus(List<AttendanceList> attendances, DateTime date) {
    final record = attendances.firstWhere(
          (element) => DateFormat('yyyy-MM-dd').format(DateTime.parse(element.createdAt!)) == DateFormat('yyyy-MM-dd').format(date),
      orElse: () => AttendanceList(attendanceStatusName: 'Chưa có dữ liệu'),
    );
    return record.attendanceStatusName!;
  }

  String _getTeacherName() {
    return 'G/V Nguyễn Thị Ngân';
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Điểm danh",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(const LeaveRequestForm());
            },
            child: Text(
              "Xin Nghỉ Phép",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          controller: _tabController,
          tabs: [
            Tab(text: 'ĐIỂM DANH'),
            Tab(text: 'CHỜ DUYỆT (0)'),
            Tab(text: 'ĐÃ DUYỆT'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAttendance(),
          _pendingAttendance(),
          _buildAttendanceDone()
        ],
      ),
    );
  }

  Widget _buildAttendance() {
    return FutureBuilder<List<AttendanceList>>(
      future: futureAttendance,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No attendance data available.'));
        } else {
          final attendances = snapshot.data!;
          return ListView.builder(
            itemCount: _recentDates.length,
            itemBuilder: (context, index) {
              final date = _recentDates[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(date),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        studentController.studentRecord.value.students?.getFullName() ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Text(
                            'Trạng thái: ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            _getAttendanceStatus(attendances, date),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Người điểm danh: ${_getTeacherName()}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _pendingAttendance() {
    return Center(child: Text('Chưa có dữ liệu'));
  }

  Widget _buildAttendanceDone() {
    return Center(child: Text('Chưa có dữ liệu'));
  }
}
