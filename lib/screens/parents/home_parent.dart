import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/model/action/article_model.dart' as model;
import 'package:project_sem4_flutter_app_mobile/screens/auth/login/login_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/allAction.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/attendance/attendance_creen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/schedule/schedule_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/payment/payment.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/article/article_details.dart';
import 'package:project_sem4_flutter_app_mobile/service/article_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controller/notification_controller.dart';
import 'action/meal/meal_screen.dart';
import 'action/report/report_card.dart';
import 'action/student/student_infor.dart';
import 'action/tasks_exercises/tasks_screen.dart';

final UserController ctrl = Get.find();
final StudentController studentController = Get.find();

class HomeParent extends StatefulWidget {
  const HomeParent({super.key});

  @override
  State<HomeParent> createState() => _HomeParentState();
}

final _controller = PageController();

class _HomeParentState extends State<HomeParent> {


  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved preferences

    final UserController userController = Get.find();
    userController.clearUser(); // Clear the user data in the controller

    Get.to(LoginScreen(loginType: LoginType.phuhuynh)); // Navigate to the login screen
  }

  final ArticleService articleService = ArticleService();
  late Future<List<model.ArticleModel>> _articlesFuture;
  @override
  void initState() {
    _articlesFuture = articleService.getAllArticles();

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
      NotificationController.onNotificationCreatedMethod,
      onDismissActionReceivedMethod:
      NotificationController.onDismissActionReceivedMethod,
      onNotificationDisplayedMethod:
      NotificationController.onNotificationDisplayedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(ctrl2.studentRecord.value.schoolYearClass?.id);
    final List<Map<String, dynamic>> workData = [
      {
        'title': "Học phí,Khoản thu",
        'icon': FontAwesomeIcons.graduationCap,
        'action': () => {Get.to(StudentPaymentScreen())},
        'color': Colors.blue
      },
      {
        'title': "Điểm danh,Xin nghỉ học",
        'icon': FontAwesomeIcons.schoolCircleCheck,
        'action': () => {Get.to(AttendanceScreen())},
        'color': Colors.redAccent
      },

      {
        'title': "Bảng điểm",
        'icon': FontAwesomeIcons.calendarDay,
        'action': () => {Get.to(ReportCardScreen())},
        'color': Colors.yellow
      },
      {
        'title': "Nhiệm vụ,Bài tập",
        'icon': FontAwesomeIcons.bookOpen,
        'action': () => {Get.to(TaskScreen())},
        'color': Colors.redAccent
      },

      {
        'title': "Thông tin học sinh",
        'icon': FontAwesomeIcons.addressCard,
        'action': () => {Get.to(StudentInfoScreen())},
        'color': Colors.yellow
      },

      // 2
      {
        'title': "Thời khoá biểu lớp học",
        'icon': FontAwesomeIcons.calendarDays,
        'action': () => {Get.to(ScheduleScreen())},
        'color': Colors.cyan
      },
      {
        'title': "Thực đơn bữa ăn",
        'icon': FontAwesomeIcons.bowlRice,
        'action': () => {Get.to(MenuScreen())},
        'color': Colors.redAccent
      },
      {
        'title': "Trang số liệu học",
        'icon': FontAwesomeIcons.usersRectangle,
        'action': () => {},
        'color': Colors.cyan
      },
      {
        'title': "Quét QR code",
        'icon': FontAwesomeIcons.qrcode,
        'action': () => {},
        'color': Colors.pink
      },
      {
        'title': "Đăng ký, Khảo sát",
        'icon': FontAwesomeIcons.calendar,
        'action': () => {},
        'color': Colors.blueGrey
      },
      {
        'title': "Trang điện Tử",
        'icon': FontAwesomeIcons.globe,
        'action': () => {},
        'color': Colors.blue
      },
      {
        'title': "Thời khoá",
        'icon': FontAwesomeIcons.heart,
        'action': () => {},
        'color': Colors.greenAccent
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            // scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                            child: Text(
                              "avatar",
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Center(
                                child: Text(
                                  "${ctrl.user.value.userDetail?.fullName()}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Text(
                              "Phụ huynh của : ${studentController.studentRecord
                                  .value.students?.getFullName()}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        logout(context);
                      },
                    ),

                  ],
                ),
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
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          side: BorderSide(width: 0, color: Colors.white),
                        ),
                        onPressed: () {
                          Get.to(AllActionScreen());
                        },
                        child: const Text(
                          "Tất Cả",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
                SizedBox(
                  height: 277,
                  child: PageView(
                    controller: _controller,
                    children: [
                      workViewDetail(workData.getRange(0, 6).toList()),
                      workViewDetail(workData.getRange(6, 12).toList()),
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 2,
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
                          image: AssetImage("assets/images/vnpay.jpeg"),
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
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          side: BorderSide(width: 0, color: Colors.white),
                        ),
                        onPressed: () {},
                        child: const Text("Xem thêm",
                            style: TextStyle(color: Colors.black)))
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: FutureBuilder<List<model.ArticleModel>>(
                    future: _articlesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No articles found'));
                      } else {
                        List<model.ArticleModel> articles = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: articles.length,
                          itemBuilder: (BuildContext context, int index) {
                        model.ArticleModel  article = articles[index];
                            return _ArticleCard(article, context);
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // test logout
    );
  }

  Widget workViewDetail(List<Map<String, dynamic>> workdetail) {
    return Container(
      child: GridView.count(
        childAspectRatio: 6 / 7,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        crossAxisCount: 3,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        children: workdetail
            .asMap()
            .map((key, value) =>
            MapEntry(
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
}


Widget _ArticleCard(model.ArticleModel article, BuildContext context) {
  // Use the first image from the article's images list as the cover image
  String coverImage = article.images.isNotEmpty ? article.images.first.url : 'default_image_url';

  return GestureDetector(
    onDoubleTap: () {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: "basic_channel",
          ticker: "hello",
          body: "new notification",
        ),
      );
    },
    onTap: () {
      Get.to(ArticleDetails(
        id: article.id,
        title: article.title,
        imageUrl: coverImage,
        content: article.content,
      ));
    },
    child: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      width: 300,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              coverImage,
              height: 150,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "date", // You can replace this with the actual date if available in the Article model
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            article.content,
            softWrap: true,
            maxLines: 5,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}


