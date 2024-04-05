import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/home_screen.dart';
import 'package:project_sem4_flutter_app_mobile/provider/theme_provider.dart';
import 'package:project_sem4_flutter_app_mobile/screens/auth/login/login_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/home_parent.dart';
import 'package:project_sem4_flutter_app_mobile/screens/select_action_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/teacher/teacher_actions.dart';
import 'package:provider/provider.dart';

import 'controller/user_controller.dart';
import 'data/constants.dart';

void main() {
  Get.put(UserController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
final UserController userController = Get.put(UserController());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Manage School',
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeProvider>().getThemeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: primaryLightColor,
          secondary: secondaryLightColor,
          onSecondary: onSecondaryLightColor,
          background: bgLightColor,
          onPrimary: Color(0xFF2A2A2A),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
            primary: primaryDarkColor,
            onPrimary: Color(0xF7F1F1F1),
            secondary: secondaryDarkColor,
            onSecondary: onSecondaryDarkColor,
            background: bgLightColor,
            brightness: Brightness.dark),
      ),
      home: SelectActionScreen(),
      routes: {
        '/select_action': (context) => SelectActionScreen(),
        '/home_parent': (context) => const HomeScreen(),
        '/teacher_action': (context) => TeacherActions()
      },
      builder: EasyLoading.init(),
    );
  }
}
