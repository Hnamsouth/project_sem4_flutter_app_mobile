import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/attendance/take_leave.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          "Điểm danh,Xin nghỉ học",
          style: TextStyle(fontSize: 20),
        ),
        bottom: TabBar(
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
}

Widget _buildAttendance() {
  return Stack(
      // padding: const EdgeInsets.all(16.0),
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
                      onPressed: () {
                        // Handle back button press
                      },
                    ),
                    Text(
                      'Thứ Ba, 17/05/2024',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        // Handle forward button press
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hà Sỹ Duy Anh - 1A1',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Hôm nay',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  'Trạng thái: ',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'Đi học',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Người điểm danh: G/V Nguyễn Thị Ngân',
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
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          onPressed: () {
            Get.to(TakeLeaveScreen());
          },
          child: Text("Xin Nghỉ Học",style: TextStyle(
            color: CupertinoColors.white
          ),),
        ))
      ]);
}


Widget _pendingAttendance(){
  return Center(child: Text('Chưa có dữ liệu'));
}
Widget _buildAttendanceDone(){
  return Center(child: Text('Chưa có dữ liệu'));
}
