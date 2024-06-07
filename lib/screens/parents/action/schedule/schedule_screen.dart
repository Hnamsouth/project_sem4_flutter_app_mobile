// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../controller/student_controller.dart';
// import '../../../../model/schedule_model.dart';
// import '../../../../service/schedule_service.dart';
//
// final StudentController ctrl = Get.find();
// final int? _id2 = ctrl.studentRecord.value.schoolYearClass?.id;
//
// class ScheduleScreen extends StatefulWidget {
//   @override
//   _ScheduleScreenState createState() => _ScheduleScreenState();
// }
//
// class _ScheduleScreenState extends State<ScheduleScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Future<Map<String, List<Schedule>>>? futureLessons;
//
//   Future<Map<String, List<Schedule>>> getSchedule() async {
//     if (_id2 == null) {
//       throw Exception('Không thể tải thời khóa biểu vì thiếu ID lớp học.');
//     }
//     List schedules = (await ScheduleService.getSchedule(_id2!)) as List;
//     List<Schedule> scheduleList = schedules.map((e) => Schedule.fromJson(e)).toList();
//
//     Map<String, List<Schedule>> groupedSchedule = {};
//     for (var day in daysOfWeek) {
//       groupedSchedule[day] = scheduleList.where((lesson) => lesson.dayOfWeek == day).toList();
//     }
//     return groupedSchedule;
//   }
//
//   final List<String> daysOfWeek = ["T2", "T3", "T4", "T5", "T6"];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: daysOfWeek.length, vsync: this);
//     futureLessons = getSchedule();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thời Khóa Biểu'),
//         bottom: TabBar(
//           unselectedLabelColor: Colors.black,
//           labelStyle: TextStyle(
//               color: Colors.blue,
//               fontWeight: FontWeight.bold
//           ),
//           controller: _tabController,
//           tabs: daysOfWeek.map((day) => Tab(text: day)).toList(),
//         ),
//       ),
//       body: FutureBuilder<Map<String, List<Schedule>>>(
//         future: futureLessons,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return TabBarView(
//               controller: _tabController,
//               children: daysOfWeek.map((day) {
//                 List<Schedule>? lessons = snapshot.data?[day];
//                 return ListView.builder(
//                   itemCount: lessons?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     Schedule lesson = lessons![index];
//                     return ListTile(
//                       title: Text('${lesson.subjectName}'),
//                       subtitle: Text(
//                           'Tiết ${lesson.indexLesson} - ${lesson.studyTime == "SANG" ? "Sáng" : "Chiều"}'),
//                             trailing: Text('Giáo viên: ${lesson.teacherName}')  ,
//                     );
//                   },
//                 );
//               }).toList(),
//             );
//           } else {
//             return Center(child: Text('Không có dữ liệu'));
//           }
//         },
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/student_controller.dart';
import '../../../../model/schedule_model.dart';
import '../../../../service/schedule_service.dart';

final StudentController ctrl = Get.find();
final int? _id2 = ctrl.studentRecord.value.schoolYearClass?.id;

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Future<Map<String, List<Schedule>>>? futureLessons;

  Future<Map<String, List<Schedule>>> getSchedule() async {
    if (_id2 == null) {
      throw Exception('Không thể tải thời khóa biểu vì thiếu ID lớp học.');
    }
    List schedules = (await ScheduleService.getSchedule(_id2!)) as List;
    List<Schedule> scheduleList = schedules.map((e) => Schedule.fromJson(e)).toList();

    Map<String, List<Schedule>> groupedSchedule = {};
    for (var day in daysOfWeek) {
      groupedSchedule[day] = scheduleList.where((lesson) => lesson.dayOfWeek == day).toList();
    }
    return groupedSchedule;
  }

  final List<String> daysOfWeek = ["T2", "T3", "T4", "T5", "T6"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: daysOfWeek.length, vsync: this);
    futureLessons = getSchedule();
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
        title: Text('Thời Khóa Biểu'),
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
          ),
          controller: _tabController,
          tabs: daysOfWeek.map((day) => Tab(text: day)).toList(),
        ),
      ),
      body: FutureBuilder<Map<String, List<Schedule>>>(
        future: futureLessons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (snapshot.hasData) {
            return TabBarView(
              controller: _tabController,
              children: daysOfWeek.map((day) {
                List<Schedule>? lessons = snapshot.data?[day];
                List<Schedule> morningLessons = lessons?.where((lesson) => lesson.studyTime == 'SANG').toList() ?? [];
                List<Schedule> afternoonLessons = lessons?.where((lesson) => lesson.studyTime == 'CHIEU').toList() ?? [];

                return ListView(
                  children: [
                    if (morningLessons.isNotEmpty)
                      ListTile(
                        title: Text('Buổi Sáng', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ...morningLessons.map((lesson) => ListTile(
                      subtitle: Text('${lesson.subjectName}'),
                      title: Text('Tiết ${lesson.indexLesson! >= 5 ? lesson.indexLesson! - 4 : lesson.indexLesson}'),
                      trailing: Text('Giáo viên: ${lesson.teacherName}'),
                    )).toList(),
                    if (afternoonLessons.isNotEmpty)
                      ListTile(
                        title: Text('Buổi Chiều', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ...afternoonLessons.map((lesson) => ListTile(
                      subtitle: Text('${lesson.subjectName}'),
                      title: Text('Tiết ${lesson.indexLesson! >= 5 ? lesson.indexLesson! - 4 : lesson.indexLesson}'),
                      trailing: Text('Giáo viên: ${lesson.teacherName}'),
                    )).toList(),
                  ],
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }
}
