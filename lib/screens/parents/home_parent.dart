import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../service/user_service.dart';

class HomeParent extends StatefulWidget {
  const HomeParent({super.key});
  @override
  State<HomeParent> createState() => _HomeParentState();
}

final _controller = PageController();

class _HomeParentState extends State<HomeParent> {
  @override
  Widget build(BuildContext context) {
    final UserController ctrl = Get.find();
    void _logout() {
      UserService.logout();
      Get.offNamed('/select_action');
    }

    final List<Map<String, dynamic>> workData = [
      {
        'title': "Học phí,Khoản thu",
        'icon': FontAwesomeIcons.graduationCap,
        'action': () => {},
        'color': Colors.redAccent
      },
      {
        'title': "Điểm danh,Xin nghỉ học",
        'icon': FontAwesomeIcons.schoolCircleCheck,
        'action': () => {},
        'color': Colors.redAccent
      },
      {
        'title': "Hoạt động hàng ngày",
        'icon': FontAwesomeIcons.calendarDays,
        'action': () => {},
        'color': Colors.redAccent
      },
      {
        'title': "Phiếu đánh giá học tập",
        'icon': FontAwesomeIcons.calendarDay,
        'action': () => {},
        'color': Colors.redAccent
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
        'action': () => {},
        'color': Colors.redAccent
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
        'color': Colors.redAccent
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
        'title': "Thời khoá biểu lớp học",
        'icon': FontAwesomeIcons.heart,
        'action': () => {},
        'color': Colors.redAccent
      },
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        height: 100,
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                          child: Text("A"),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "eNetViet",
                        style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Các chức năng",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Text("Tất Cả"))
                    ],
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // work view
                  SizedBox(
                    height: 320,
                    child: PageView(
                      controller: _controller,
                      children: [
                        workViewDetail(workData.getRange(0, 6).toList()),
                        workViewDetail(workData.getRange(6, 12).toList()),
                        workViewDetail(workData.getRange(12, 13).toList()),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const SlideEffect(
                      activeDotColor: Colors.white54,
                      dotHeight: 10,
                      dotColor: Colors.blue,
                      dotWidth: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/B_Ill_Education_Back_to_school_min_a72a89f00f.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: null,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tin tức - Sự kiện",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Text("Tất Cả"))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        // test logout
        floatingActionButton: FloatingActionButton(
          onPressed: _logout,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          child: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ));
  }

  Widget workViewDetail(List<Map<String, dynamic>> workdetail) {
    return Container(
      child: GridView.count(
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
                            onPressed: () => value['action'],
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
}
