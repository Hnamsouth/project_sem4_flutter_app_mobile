import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/timetable/timetable_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/tuition/tuition_screen.dart';

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
        Get.to(TuitionScreen())
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
      'title': "Hoạt động hàng ngày",
      'icon': FontAwesomeIcons.calendarDays,
      'action': () => {},
      'color': Colors.pink
    },
    {
      'title': "Phiếu đánh giá học tập",
      'icon': FontAwesomeIcons.calendarDay,
      'action': () => {},
      'color': Colors.yellow
    },
    {
      'title': "Nhiệm vụ,Bài tập",
      'icon': FontAwesomeIcons.bookOpen,
      'action': () => {},
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
        Get.to(TimetableScreen())
      },
      'color': Colors.cyan
    },
    {
      'title': "Thực đơn bữa ăn",
      'icon': FontAwesomeIcons.bowlRice,
      'action': () => {},
      'color': Colors.redAccent
    },
    {
      'title': "Thông tin học sinh",
      'icon': FontAwesomeIcons.addressCard,
      'action': () => {},
      'color': Colors.yellow
    },
    {
      'title': "Trang số liệu học",
      'icon': FontAwesomeIcons.usersRectangle,
      'action': () => {},
      'color': Colors.redAccent
    },
    {
      'title': "Quét QR code",
      'icon': FontAwesomeIcons.qrcode,
      'action': () => {},
      'color': Colors.redAccent
    },
    {
      'title': "Trang điện Tử",
      'icon': FontAwesomeIcons.globe,
      'action': () => {},
      'color': Colors.redAccent
    },
    {
      'title': "Thời khoá biểu lớp học 22",
      'icon': FontAwesomeIcons.heart,
      'action': () => {},
      'color': Colors.redAccent
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
              workViewDetail(workData.getRange(0, 13).toList()),
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
