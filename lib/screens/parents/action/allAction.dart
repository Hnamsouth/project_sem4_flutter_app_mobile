import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/meal/meal_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/report/report_card.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/schedule/schedule_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/student/student_infor.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/schedule/schedule_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tasks_exercises/tasks_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/payment/payment_details.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/payment/payment.dart';
import 'package:project_sem4_flutter_app_mobile/screens/test/test_payment.dart';
import 'package:project_sem4_flutter_app_mobile/service/student_service.dart';

import 'attendance/attendance_creen.dart';

class AllActionScreen extends StatefulWidget {
  const AllActionScreen({super.key});

  @override
  State<AllActionScreen> createState() => _AllActionScreenState();
}
final _controller = PageController();



class _AllActionScreenState extends State<AllActionScreen> {

  final List<Map<String, dynamic>> workData = [
    {
      'title': "Học phí,Khoản thu",
      'icon': FontAwesomeIcons.graduationCap,
      'action': () => {
        Get.to( StudentPaymentScreen())
      },
      'color': Colors.blue
    },
    {
      'title': "Điểm danh,Xin nghỉ học",
      'icon': FontAwesomeIcons.schoolCircleCheck,
      'action': () => {
        Get.to(AttendanceScreen())
      },
      'color': Colors.redAccent
    },

    {
      'title': "Bảng điểm",
      'icon': FontAwesomeIcons.calendarDay,
      'action': () => {
        Get.to(ReportCardScreen())
      },
      'color': Colors.yellow
    },
    {
      'title': "Nhiệm vụ,Bài tập",
      'icon': FontAwesomeIcons.bookOpen,
      'action': () => {
        Get.to(TaskScreen())
      },
      'color': Colors.redAccent
    },
    {
      'title': "Đăng ký, Khảo sát",
      'icon': FontAwesomeIcons.calendar,
      'action': () => {},
      'color': Colors.redAccent
    },
    // 2
    {
      'title': "Thời khoá biểu lớp học",
      'icon': FontAwesomeIcons.calendarDays,
      'action': () => {
        Get.to(ScheduleScreen())
      },
      'color': Colors.cyan
    },
    {
      'title': "Thực đơn bữa ăn",
      'icon': FontAwesomeIcons.bowlRice,
      'action': () => {
        Get.to(MenuScreen())
      },
      'color': Colors.redAccent
    },
    {
      'title': "Thông tin học sinh",
      'icon': FontAwesomeIcons.addressCard,
      'action': () => {
        Get.to(StudentInfoScreen())
      },
      'color': Colors.yellow
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Các chức năng"),
      ),
      body: SingleChildScrollView(
        child:  SizedBox(
          height: 800,
          child: PageView(
            controller: _controller,
            children: [
              workViewDetail(workData.getRange(0, 7).toList()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget workViewDetail(List<Map<String, dynamic>> workdetail) {
  return Container(
    child: GridView.count(
      scrollDirection: Axis.vertical,
      childAspectRatio: 6 / 7,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 45),
      crossAxisCount: 3,
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
      children: workdetail
          .asMap()
          .map((key, value) => MapEntry(
        key,
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: value['color'],
                ),
                child: IconButton(
                  color: Colors.white,
                  icon: FaIcon(value['icon'], size: 43.0),
                  onPressed: value['action'],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                value['title'].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              )
            ]),
      ))
          .values
          .toList(),
    ),
  );
}
