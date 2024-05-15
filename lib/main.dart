import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sem4_flutter_app_mobile/home_screen.dart';
import 'package:project_sem4_flutter_app_mobile/provider/theme_provider.dart';
import 'package:project_sem4_flutter_app_mobile/screens/auth/login/login_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/timetable/timetable_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/select_action_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/teacher/teacher_actions.dart';
import 'package:project_sem4_flutter_app_mobile/screens/test/example.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/user_controller.dart';
import 'data/constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserController());
  final token = await SharedPreferences.getInstance();
  final accessToken = token.getString(TokenType.accress_token.name);
  // UserService.login(data, loginType)
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
        fontFamily:'Roboto',
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: primary,
          secondary: secondary,
          onSecondary: secondaryContainer,
          background: tertiaryContainer,
          onPrimary: primaryContainer,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
            primary: primary,
            onPrimary: primaryContainer,
            secondary: secondary,
            onSecondary: secondaryContainer,
            background: tertiaryContainer,
            brightness: Brightness.dark),
      ),
      home: LoginScreen(loginType: LoginType.phuhuynh,),
      // home: MyRealtimeApp(),
      routes: {
        '/select_action': (context) => SelectActionScreen(),
        '/home_parent': (context) => const HomeScreen(),
        '/teacher_action': (context) => TeacherActions(),
        '/timetable_action': (context) => TimetableScreen()
      },
      builder: EasyLoading.init(),
    );
  }
}
