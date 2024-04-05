import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/service/user_service.dart';
import 'package:rive/rive.dart' as rive;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/login_data.dart';
import '../../parents/chat/chat_screen.dart';
import '../../parents/contact/contact_screen.dart';
import '../../parents/home_parent.dart';
import '../../parents/notification/notification_screen.dart';
import '../../parents/work/work_screen.dart';

class LoginScreen extends StatefulWidget {
  late LoginType loginType;
  LoginScreen({super.key, required this.loginType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var headers = {
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool loginLoading = false;
    DataLogin formData = DataLogin();
    final UserController c = Get.find();

    // navigator
    void loginFail() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Đăng nhập thất bại'),
              content: const Text('Thông tin đăng nhập không hợp lệ'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }

    Future<void> login() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      await Future.delayed(const Duration(seconds: 1));
      var user = await UserService.login(formData.toJson(), widget.loginType);
      if (user == null) {
        loginFail();
      } else {
        c.setUser(user);
        widget.loginType == LoginType.phuhuynh
            ? Get.offNamed('/home_parent')
            : Get.offNamed('/teacher_action');
      }
      EasyLoading.dismiss();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body:
            Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
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
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                      Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: const BoxDecoration(
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
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          )),
                      Positioned(
                          child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
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
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // color: Color.fromRGBO(255, 255, 255, 1.0),

                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                onChanged: (value) {
                                  formData.username = value;
                                },
                                style: const TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username ",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  formData.password = value;
                                },
                                obscureText: true,
                                style: const TextStyle(color: Colors.grey),
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
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
                                    const Color.fromRGBO(143, 148, 251, 1),
                                fixedSize: const Size(600, 50)),
                            onPressed: () => login(),
                            child: const Text(
                              "Đăng nhập",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      const Text(
                        "Quên mật khẩu?",
                        style:
                            TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
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
                      color: btnColor,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.onSecondary,
                          blurRadius: 3,
                          offset:
                              const Offset(1, 2), // changes position of shadow
                        )
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Get.toNamed('/select_action'),
                      icon: const Icon(
                        semanticLabel: 'Go back',
                        Icons.logout,
                        color: Colors.white,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
