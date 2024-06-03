import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Thêm package intl để định dạng ngày tháng
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/attendance/take_leave.dart';



final StudentController studentController = Get.find();
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _incrementDate() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
  }

  void _decrementDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
    });
  }

  String _getAttendanceStatus(DateTime date) {

    if (date.isAfter(DateTime.now())) {
      return 'Chưa có thông tin';
    } else {
      return 'Đi học';
    }
  }

  String _getTeacherName(DateTime date) {
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
          "Điểm danh, Xin nghỉ học",
          style: TextStyle(fontSize: 20),
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          labelStyle:
          TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          controller: _tabController,
          tabs: [
            Tab(text: 'ĐIỂM DANH'),
            Tab(
              text: 'CHỜ DUYỆT (0)',
            ),
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
    return Stack(
      children: [
        Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _decrementDate,
                    ),
                    Text(
                      DateFormat('EEEE, dd/MM/yyyy').format(_selectedDate),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: _incrementDate,
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      studentController.studentRecord.value.students?.getFullName(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                        });
                      },
                      child: Text(
                        'Hôm nay',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
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
                      _getAttendanceStatus(_selectedDate),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  'Người điểm danh: ${_getTeacherName(_selectedDate)}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          height: 50,
          bottom: 30,
          left: 10,
          right: 10,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            onPressed: () {
              Get.to(const LeaveRequestForm());
            },
            child: Text(
              "Xin Nghỉ Học",
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
        )
      ],
    );
  }

  Widget _pendingAttendance() {
    return Center(child: Text('Chưa có dữ liệu'));
  }

  Widget _buildAttendanceDone() {
    return Center(child: Text('Chưa có dữ liệu'));
  }
}
