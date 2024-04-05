import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/extensions/text_extension.dart';
import 'package:project_sem4_flutter_app_mobile/main.dart';
import 'package:project_sem4_flutter_app_mobile/model/userDetails_model.dart';
import 'package:project_sem4_flutter_app_mobile/service/api_service.dart';
import 'package:project_sem4_flutter_app_mobile/service/user_service.dart';
import 'package:quickly/quickly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/constants.dart';
import '../../provider/theme_provider.dart';
import '../widgets/select_direction.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TeacherActions extends StatelessWidget {
  TeacherActions({super.key});

  final listClass = [
    {
      "title": "Class 1",
      "direction": "/class_detail",
      "img": "https://robohash.org/Terry.png?set=set3"
    },
    {
      "title": "Class 2",
      "direction": "/class_detail",
      "img": "https://robohash.org/Terry.png?set=set4"
    },
  ];

  final listSchedule = List.generate(
      8,
      (index) => {
            "id": index,
            "subject": {
              "id": index,
              "name": "Subject $index",
            },
            "index_lession": index,
            "time_of_day": index,
            "created_at": "2022-10-10",
            "note": "Test$index",
            "schoolyear_class": {
              "id": index,
              "class_name": "Class $index",
              "class_code": "C$index",
              "room": {"id": index, "name": "Room $index"}
            }
          });

  var timeOfDay = [
    {
      "AM": [
        "08:00 - 08:45",
        "08:50 - 09:35",
        "09:40 - 10:25",
        "10:30 - 11:15",
      ],
      "PM": [
        "13:30 - 14:15",
        "14:20 - 15:05",
        "15:10 - 15:55",
        "16:00 - 16:45",
      ]
    }
  ];

  final UserController userController = Get.find();
  get userDetail => userController.user.value.userDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildAction(context),
        leadingWidth: 100,
        toolbarHeight: 80,
        title: const Text("Teacher Actions"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _listAction(
              context,
              title: "CLASSES",
              listClass: listClass,
            ),
            // schedule
            Column(
              children: [
                // schedule header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("SCHEDULE").bold.fontSize(20).centerLeft,
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: const Text("Schedule"),
                              ),
                              body: _schedule(),
                            );
                          }));
                        },
                        icon: Icon(Icons.fullscreen_exit),
                        iconSize: 30,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                          foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.onPrimary),
                        )).roundedLg
                  ],
                ).px(5),
                const SizedBox(
                  height: 10,
                ),
                // schedule table
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // header
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.keyboard_arrow_left_outlined),
                            Text("DATE").fontSize(20).bold,
                            Icon(Icons.keyboard_arrow_right_outlined),
                          ],
                        ),
                      ).pOnly(top: 10, left: 5, right: 5),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      // schedule detail
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // time - class
                          Column(
                            children: [
                              Text("08:00 - 08:45").fontSize(15).bold,
                              _divider(context),
                              Text("Class 1").fontSize(15).bold,
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          // // Get token from secure storage
          String? accessToken = prefs.getString(TokenType.accress_token.name);
          Logger().i('$accessToken');
          // var res = await DioService().get('/auth/test-auth');
          var res = await DioService().get('/auth/test-auth');
          Logger().i('$res.data');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).colorScheme.onSecondary,
    );
  }

  /// appbar
  ///
  Widget _buildAction(BuildContext context) {
    return IconButton(
        icon: const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                // backgroundImage: NetworkImage(userDetail?.avatar),
                backgroundImage:
                    NetworkImage('https://robohash.org/Terry.png?set=set5'),
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 25,
              )
            ]),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              showDragHandle: true,
              useSafeArea: true,
              constraints: const BoxConstraints(
                  maxHeight: 500, minWidth: double.infinity),
              builder: (context) => _modalDetail(context));
        });
  }

  Widget _modalDetail(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text("${userDetail?.firstname} ${userDetail?.lastname}")
              .fontSize(20)
              .bold,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.brightness_4_outlined,
                  color: Theme.of(context).colorScheme.onPrimary),
              const SizedBox(width: 10),
              Text('Change Theme',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ],
          ),
        ).onTap(() {
          Provider.of<ThemeProvider>(context, listen: false).changeTheme();
        }).px12,
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(0.3),
                    offset: const Offset(0.0, -3), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              // bottom action
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconTextButton(context,
                      text: "Setting",
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 25,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                  _iconTextButton(context, onPressed: () {
                    UserService.logout();
                    Get.toNamed('/select_action');
                  },
                      icon: Icon(
                        Icons.login_outlined,
                        size: 25,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 30,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _iconTextButton(BuildContext context,
      {String? text, Icon? icon, Function()? onPressed}) {
    return IconButton(
        onPressed: onPressed,
        icon: Row(
          children: [
            icon!,
            const SizedBox(
              width: 5,
            ),
            text != null
                ? Text(text).clOnPrimary(context).fontSize(15).bold.blue800
                : Container(),
          ],
        ));
  }

  //
  Widget _listAction(BuildContext context,
      {required String title, required List<dynamic> listClass}) {
    return Column(children: [
      Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ).bold.fontSize(20).pOnly(top: 20, left: 5).centerLeft,
      const SizedBox(
        height: 10,
      ),
      ...listClass.map((e) => SelectDirection(
            title: e["title"],
            direction: e["direction"],
            img: e["img"],
          )),
      const SizedBox(
        height: 10,
      )
    ]);
  }

  // schedule
  Widget _schedule() {
    return SfCalendar(
      allowDragAndDrop: true,
      allowViewNavigation: true,
      showDatePickerButton: true,
      showTodayButton: true,
      showWeekNumber: true,
      view: CalendarView.timelineDay,
      monthViewSettings: const MonthViewSettings(showAgenda: true),
      timeSlotViewSettings: const TimeSlotViewSettings(
          startHour: 8,
          endHour: 16,
          timeInterval: Duration(minutes: 35),
          timeIntervalWidth: 80,
          timeFormat: 'HH:mm a',
          nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
    );
  }
}
