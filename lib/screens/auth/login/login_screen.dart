import 'package:flutter/material.dart';
import 'package:project_sem4_flutter_app_mobile/model/user_model.dart';
import 'package:project_sem4_flutter_app_mobile/service/user_service.dart';
import 'package:rive/rive.dart' as rive;

import '../../../data/login_data.dart';
import '../../parents/chat/chat_screen.dart';
import '../../parents/contact/contact_screen.dart';
import '../../parents/home_parent.dart';
import '../../parents/notification/notification_screen.dart';
import '../../parents/work/work_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final List<Widget> _screens = [
    const HomeParent(),
    const ChatScreen(),
    const NotificationScreen(),
    const WorkScreen(),
    const ContactScreen(),

  ];
  int _selectedIndex = 0;

  _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  late rive.RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController =
        rive.SimpleAnimation('Animation 1', autoplay: false);
    super.initState();
  }

  var headers = {
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DataLogin formData = DataLogin();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            left: 30,
                            width: 80,
                            height: 200,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                        Positioned(
                            left: 140,
                            width: 80,
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                        Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                        Positioned(
                            child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              // color: Color.fromRGBO(255, 255, 255, 1.0),

                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextField(
                                  onChanged: (value) {
                                    formData.username = value;
                                  },
                                  style: TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username ",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    formData.password = value;
                                  },
                                  obscureText: true,
                                  style: TextStyle(color: Colors.grey),
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(143, 148, 251, 1),
                                  fixedSize: Size(600, 50)),
                              onPressed: () {
                                UserService.login(formData.toJson());
                              },
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Text(
                          "Quên mật khẩu?",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.only(left: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.onSecondary,
                            blurRadius: 3,
                            offset: const Offset(
                                1, 2), // changes position of shadow
                          )
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.onPrimary,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // rive.RiveAnimation.asset(
          //   // controllers: [_btnAnimationController],
          //   "assets/RiveAssets/loadingbook.riv",
          // ),
        ]));
  }
}
