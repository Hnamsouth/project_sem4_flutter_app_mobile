import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/model/action/attendance_model.dart';
import 'package:project_sem4_flutter_app_mobile/model/action/take_leave_model.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/attendance/take_leave.dart';
import 'package:project_sem4_flutter_app_mobile/service/attendance_service.dart';
import 'package:project_sem4_flutter_app_mobile/service/take_leave_service.dart';

final StudentController studentController = Get.find();

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<AttendanceList>> futureAttendance;
  late Future<List<TakeLeave>> futureTakeLeaveList;
  List<AttendanceList> attendances = [];
  int pendingLeaveCount = 0;

  DateTime? _selectedDay;
  AttendanceList? _selectedAttendance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    initializeDateFormatting('vi_VN', null).then((_) {
      setState(() {});
    });
    futureAttendance = getAttendances();
    futureAttendance.then((data) {
      setState(() {
        attendances = data;
      });
      print('Attendance data loaded: ${attendances.length} records'); // Logging
    }).catchError((error) {
      print('Error loading attendance data: $error'); // Logging error
    });
    futureTakeLeaveList = takeLeaveList();
    futureTakeLeaveList.then((data) {
      setState(() {
        pendingLeaveCount = data.length;
      });
    });
  }

  Future<List<AttendanceList>> getAttendances() async {
    final data = await AttendanceService.getAttendance(
        studentController.studentRecord.value.students!.id);
    return data
        .map<AttendanceList>((json) => AttendanceList.fromJson(json))
        .toList();
  }

  Future<List<TakeLeave>> takeLeaveList() async {
    final data = await TakeLeaveService.getTakeLeave(
        studentController.studentRecord.value.students!.id);
    return data.map<TakeLeave>((json) => TakeLeave.fromJson(json)).toList();
  }

  String _getAttendanceStatus(List<AttendanceList> attendances, DateTime date) {
    final record = attendances.firstWhere(
      (element) {
        if (element.createdAt == null) {
          return false;
        }
        return DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(element.createdAt!)) ==
            DateFormat('yyyy-MM-dd').format(date);
      },
      orElse: () => AttendanceList(attendanceStatusName: 'Chưa có dữ liệu'),
    );
    return record.attendanceStatusName != null
        ? record.attendanceStatusName!
        : 'Chưa có dữ liệu';
  }

  AttendanceList _getAttendanceForDay(
      List<AttendanceList> attendances, DateTime date) {
    return attendances.firstWhere(
      (element) {
        if (element.createdAt == null) {
          return false;
        }
        return DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(element.createdAt!)) ==
            DateFormat('yyyy-MM-dd').format(date);
      },
      orElse: () => AttendanceList(attendanceStatusName: 'Chưa có dữ liệu'),
    );
  }

  int _countDaysWithStatus(List<AttendanceList> attendances, String status) {
    return attendances
        .where((attendance) => attendance.attendanceStatusName == status)
        .length;
  }

  String? _getTeacherName() {
    return studentController.studentRecord.value.schoolYearClass
        ?.teacherSchoolYear.teacher.sortName;
    // return 'G/V Nguyễn Thị Ngân';
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
          labelStyle:
              TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          controller: _tabController,
          tabs: [
            Tab(text: 'ĐIỂM DANH'),
            Tab(text: 'CHỜ DUYỆT ($pendingLeaveCount)'),
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

  Widget _pendingAttendance() {
    return FutureBuilder<List<TakeLeave>>(
      future: futureTakeLeaveList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Chưa có dữ liệu'));
        } else {
          final takeLeaveList = snapshot.data!;
          return ListView.builder(
            itemCount: takeLeaveList.length,
            itemBuilder: (context, index) {
              final takeLeave = takeLeaveList[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        studentController.studentRecord.value.students
                                ?.getFullName() ??
                            'Unknown',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Lý do: ${takeLeave.note}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'Từ ngày: ${takeLeave.startDate != null ? DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(takeLeave.startDate!) : 'N/A'}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'Đến ngày: ${takeLeave.endDate != null ? DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(takeLeave.endDate!) : 'N/A'}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Trạng thái: ${takeLeave.statusName}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue,
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

  Widget _buildAttendanceDone() {
    return Center(child: Text('Chưa có dữ liệu'));
  }

  Widget _buildAttendance() {

    final diHocDates = attendances
        .where((attendance) => attendance.attendanceStatusName == 'Có mặt')
        .map((attendance) => DateTime.parse(attendance.createdAt!))
        .toList();
    final diMuonDates = attendances
        .where((attendance) => attendance.attendanceStatusName == 'Nghỉ có phép')
        .map((attendance) => DateTime.parse(attendance.createdAt!))
        .toList();
    final nghiDates = attendances
        .where((attendance) => attendance.attendanceStatusName == 'Nghỉ không phép')
        .map((attendance) => DateTime.parse(attendance.createdAt!))
        .toList();


    return FutureBuilder<List<AttendanceList>>(

      future: futureAttendance,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi tải dữ liệu điểm danh'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Không có dữ liệu điểm danh'));
        }

        final attendances = snapshot.data!;
        int daysPresent = _countDaysWithStatus(attendances, 'Có mặt');
        int daysLate = _countDaysWithStatus(attendances, 'Nghỉ không phép');
        int daysAbsent = _countDaysWithStatus(attendances, 'Nghỉ có phép');

        return Column(
          children: [
            // Calendar
            Card(
              child: TableCalendar(
                locale: "vi_VN",
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2050, 3, 14),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle().copyWith(color: Colors.red),
                  holidayTextStyle: TextStyle().copyWith(color: Colors.red),
                  markersMaxCount: 1,
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _selectedAttendance =
                        _getAttendanceForDay(attendances, selectedDay);
                  });
                },
                eventLoader: (day) {
                  final status = _getAttendanceStatus(attendances, day);
                  return [status];
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isNotEmpty) {
                      final status = events.first;
                      Color? backgroundColor;

                      if (status == 'Nghỉ có phép') {
                        backgroundColor = Colors.green;
                      } else if (status == 'Có mặt') {
                        backgroundColor = Colors.red;
                      } else if (status == 'Nghỉ không phép') {
                        backgroundColor = Colors.orange;
                      }

                      return Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 0,
                          height: 0,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                  defaultBuilder: (context, date, _) {
                    return FutureBuilder(
                      future: futureAttendance,
                      builder: (context,
                          AsyncSnapshot<List<AttendanceList>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<AttendanceList> attendances = snapshot.data!;
                          String status =
                              _getAttendanceStatus(attendances, date);
                          Color? backgroundColor;

                          if (status == 'Nghỉ có phép') {
                            backgroundColor = Color.fromRGBO(0, 255, 255, 1);
                          } else if (status == 'Có mặt') {
                            backgroundColor = Color.fromRGBO(153, 255, 153,1);
                          } else if (status == 'Nghỉ không phép') {
                            backgroundColor = Color.fromRGBO( 255, 255,0, 1);
                          } else {
                            backgroundColor = Colors.transparent;
                          }

                          if (status == 'Chưa có dữ liệu') {
                            return GestureDetector(
                              onTap: () {
                                _showNoDataModal(context, date);
                              },
                              child: Container(
                                width: 40, // Adjust the width as needed
                                height: 40, // Adjust the height as needed
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Adjust text color if needed
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 40, // Adjust the width as needed
                                  height: 40, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color: Colors
                                        .black, // Adjust text color if needed
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            // Total working days
            // Attendance Recap
            Column(
              children: [
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAttendanceCard('Đi học', daysPresent, Color.fromRGBO(153, 255, 153,1),diHocDates),
                    _buildAttendanceCard('Nghỉ không phép', daysLate,Color.fromRGBO(0, 255, 255, 1),nghiDates),
                    _buildAttendanceCard('Nghỉ có phép', daysAbsent,Color.fromRGBO( 255, 255,0, 1),diMuonDates),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(child: _buildAttendanceCardDetails()),
          ],
        );
      },
    );
  }

  Widget _buildAttendanceCard(String title, int count, Color color, List<DateTime> dates) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(dates[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: 125,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                count.toString(),
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoDataModal(BuildContext context, DateTime date) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Không có dữ liệu cho ngày ${DateFormat('dd/MM/yyyy').format(date)}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Vui lòng đợi giáo viên chủ nhiệm cập nhật.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng modal
                },
                child: Text('Đóng'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttendanceCardDetails() {
    if (_selectedAttendance == null || _selectedAttendance!.createdAt == null) {
      return Center(child: Text('Không có dữ liệu chi tiết'));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Chi tiết",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ngày tháng ",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedAttendance!.createdAt!))}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Học sinh ",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  studentController.studentRecord.value.students
                          ?.getFullName() ??
                      'Unknown',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trạng thái ',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  "${_selectedAttendance!.attendanceStatusName}",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Giáo viên điểm danh  ',
                  style: TextStyle(
                    fontSize: 16.0,
                  )),
              Text(
                '${_getTeacherName()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}




