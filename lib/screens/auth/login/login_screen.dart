import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/service/user_service.dart';
import 'package:rive/rive.dart' as rive;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/login_data.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';


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

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.green,
          body: ListView(
              padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
              shrinkWrap: true,
              reverse: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 20),
                      child: Image.asset(
                        'assets/images/plants2.png',
                        scale: 1.5,
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      height: 555,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: HexColor("#ffffff"),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Đăng nhập",
                              style: GoogleFonts.poppins(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#4f4f4f"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Username",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyTextField(
                                    onChanged: (value) {
                                      formData.username = value;
                                    },
                                    hintText: "Username",
                                    obscureText: false,
                                    prefixIcon: const Icon(Icons.supervised_user_circle),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Password",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyTextField(


                                    onChanged: (value) {
                                      formData.password = value;
                                    },
                                    hintText: "**************",
                                    obscureText: true,
                                    prefixIcon: const Icon(Icons.lock_outline),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MyButton(
                                    onPressed: () {
                                      login();
                                    },
                                    buttonText: 'Đăng Nhập', btnHeight: 55, btnWidth: 375,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(65, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text("Quên mật khẩu?",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: HexColor("#8d8d8d"),
                                            )),
                                        TextButton(
                                            child: Text(
                                              "Tại đây !",
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: HexColor("#44564a"),
                                              ),
                                            ),
                                            onPressed: () => {}),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),


              ])),
    );






  }
}
