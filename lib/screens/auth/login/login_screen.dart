// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
// import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
// import 'package:project_sem4_flutter_app_mobile/service/user_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../controller/student_controller.dart';
// import '../../../data/login_data.dart';
// import '../../widgets/my_button.dart';
// import '../../widgets/my_textfield.dart';
//
// class LoginScreen extends StatefulWidget {
//   late LoginType loginType;
//
//   LoginScreen({super.key, required this.loginType});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final LocalAuthentication auth = LocalAuthentication();
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   DataLogin formData = DataLogin();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//   Future<void> authenticateWithBiometrics() async {
//     bool authenticated = false;
//     try {
//       authenticated = await auth.authenticate(
//         localizedReason: 'Scan your face to authenticate',
//         options: const AuthenticationOptions(
//           biometricOnly: true,
//         ),
//       );
//     } catch (e) {
//       authenticated = false;
//     }
//
//     if (authenticated) {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       formData.username = prefs.getString('username') ?? '';
//       formData.password = prefs.getString('password') ?? '';
//
//       if (formData.username!.isNotEmpty && formData.password!.isNotEmpty) {
//         await login();
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Đăng nhập thất bại'),
//               content: const Text('Không có thông tin đăng nhập đã lưu.'),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Xác thực thất bại'),
//             content: const Text('Không thể xác thực sinh trắc học.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//
//
//
//   Future<void> login() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     EasyLoading.show(
//       status: 'loading...',
//       maskType: EasyLoadingMaskType.black,
//     );
//     await Future.delayed(const Duration(seconds: 1));
//     try {
//       var user = await UserService.login(formData.toJson(), widget.loginType);
//       if (user == null) {
//         loginFail();
//       } else {
//         final UserController c = Get.find();
//         c.setUser(user);
//         final int? userId = c.user.value.id;
//         if (userId != null) {
//           final StudentController studentController = Get.find();
//           await studentController.updateStudentRecord(userId);
//         }
//
//         // Save user info to SharedPreferences
//         await prefs.setString('username', formData.username!);
//         await prefs.setString('password', formData.password!);
//
//         widget.loginType == LoginType.phuhuynh
//             ? Get.offNamed('/home_parent')
//             : Get.offNamed('/teacher_action');
//       }
//     } catch (e) {
//       print('Login error: $e');
//       loginFail();
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }
//
//   void loginFail() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Đăng nhập thất bại'),
//             content: const Text('Thông tin đăng nhập không hợp lệ'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.green,
//           body: ListView(
//               padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
//               shrinkWrap: true,
//               reverse: true,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Transform.translate(
//                       offset: const Offset(0, 20),
//                       child: Image.asset(
//                         'assets/images/plants2.png',
//                         scale: 1.5,
//                         width: double.infinity,
//                       ),
//                     ),
//                     Container(
//                       height: 555,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: HexColor("#ffffff"),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(40),
//                           topRight: Radius.circular(40),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Đăng nhập",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 40,
//                                 fontWeight: FontWeight.bold,
//                                 color: HexColor("#4f4f4f"),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Tài khoản",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                       color: HexColor("#8d8d8d"),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   MyTextField(
//                                     onChanged: (value) {
//                                       formData.username = value;
//                                     },
//                                     hintText: "Tên đăng nhập ...",
//                                     obscureText: false,
//                                     prefixIcon: const Icon(
//                                         Icons.supervised_user_circle),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     "Mật khẩu",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                       color: HexColor("#8d8d8d"),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   MyTextField(
//                                     onChanged: (value) {
//                                       formData.password = value;
//                                     },
//                                     hintText: "******",
//                                     obscureText: true,
//                                     prefixIcon: const Icon(Icons.lock_outline),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   Row(
//                                     children: [
//                                       MyButton(
//                                         onPressed: () {
//                                           login();
//                                         },
//                                         buttonText: 'Đăng Nhập',
//                                         btnHeight: 55,
//                                         btnWidth: 250,
//                                       ),
//                                        IconButton(
//                                           onPressed: authenticateWithBiometrics,
//                                           icon: Image.network("https://e7.pngegg.com/pngimages/507/1004/png-clipart-iphone-x-iphone-8-face-id-apple-touch-id-idle-away-in-seeking-pleasure-face-text-thumbnail.png",width: 50,height: 50,),
//                                         ),
//
//
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 12,
//                                   ),
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.fromLTRB(65, 0, 0, 0),
//                                     child: Row(
//                                       children: [
//                                         Text("Quên mật khẩu?",
//                                             style: GoogleFonts.poppins(
//                                               fontSize: 15,
//                                               color: HexColor("#8d8d8d"),
//                                             )),
//                                         TextButton(
//                                             child: Text(
//                                               "Tại đây !",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 15,
//                                                 color: HexColor("#44564a"),
//                                               ),
//                                             ),
//                                             onPressed: () => {}),
//                                       ],
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ])),
//     );
//   }
// }
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:local_auth/local_auth.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/student_controller.dart';
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
  final LocalAuthentication auth = LocalAuthentication();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DataLogin formData = DataLogin();

  @override
  void initState() {
    super.initState();
    _checkForSavedCredentials();
  }

  Future<void> _checkForSavedCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (savedUsername != null && savedPassword != null) {
      formData.username = savedUsername;
      formData.password = savedPassword;
      authenticateWithBiometrics();
    }
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your face to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      authenticated = false;
    }

    if (authenticated) {
      await login();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Xác thực thất bại'),
            content: const Text('Không thể xác thực sinh trắc học.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    await Future.delayed(const Duration(seconds: 1));
    try {
      var user = await UserService.login(formData.toJson(), widget.loginType);
      if (user == null) {
        loginFail();
      } else {
        final UserController c = Get.find();
        c.setUser(user);
        final int? userId = c.user.value.id;
        if (userId != null) {
          final StudentController studentController = Get.find();
          await studentController.updateStudentRecord(userId);
        }

        // Save user info to SharedPreferences
        await prefs.setString('username', formData.username!);
        await prefs.setString('password', formData.password!);

        widget.loginType == LoginType.phuhuynh
            ? Get.offNamed('/home_parent')
            : Get.offNamed('/teacher_action');
      }
    } catch (e) {
      print('Login error: $e');
      loginFail();
    } finally {
      EasyLoading.dismiss();
    }
  }

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

  @override
  Widget build(BuildContext context) {
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
                                    "Tài khoản",
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
                                    hintText: "Tên đăng nhập ...",
                                    obscureText: false,
                                    prefixIcon: const Icon(
                                        Icons.supervised_user_circle),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Mật khẩu",
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
                                    hintText: "******",
                                    obscureText: true,
                                    prefixIcon: const Icon(Icons.lock_outline),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      MyButton(
                                        onPressed: () {
                                          login();
                                        },
                                        buttonText: 'Đăng Nhập',
                                        btnHeight: 55,
                                        btnWidth: 250,
                                      ),
                                      IconButton(
                                        onPressed: authenticateWithBiometrics,
                                        icon: Image.network(
                                          "https://e7.pngegg.com/pngimages/507/1004/png-clipart-iphone-x-iphone-8-face-id-apple-touch-id-idle-away-in-seeking-pleasure-face-text-thumbnail.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ],
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
