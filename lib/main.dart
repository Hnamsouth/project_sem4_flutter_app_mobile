import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:project_sem4_flutter_app_mobile/controller/student_controller.dart';
import 'package:project_sem4_flutter_app_mobile/home_screen.dart';
import 'package:project_sem4_flutter_app_mobile/provider/theme_provider.dart';
import 'package:project_sem4_flutter_app_mobile/screens/auth/login/login_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/schedule/schedule_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/select_action_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/teacher/teacher_actions.dart';
import 'package:project_sem4_flutter_app_mobile/service/student_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'controller/user_controller.dart';
import 'data/constants.dart';
import 'firebase_options.dart';
import 'model/student_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  Get.put(UserController());
  Get.put(StudentController());



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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', 'VN'), // Vietnamese
        const Locale('en', 'US'), // English
        // Add other locales here if needed
      ],
      // home: MyRealtimeApp(),
      routes: {
        '/select_action': (context) => SelectActionScreen(),
        '/home_parent': (context) => const HomeScreen(),
        '/teacher_action': (context) => TeacherActions(),
        '/timetable_action': (context) =>  ScheduleScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
