import 'package:flutter/material.dart';
import 'package:project_sem4_flutter_app_mobile/provider/theme_provider.dart';
import 'package:project_sem4_flutter_app_mobile/screens/auth/login/login_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/select_action_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/select_role/select_role.dart';
import 'package:project_sem4_flutter_app_mobile/screens/teacher/teacher_actions.dart';
import 'package:provider/provider.dart';

import 'data/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          onPrimary: Color(0xFF232323),
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
            background: bgDarkColor,
            brightness: Brightness.dark),
      ),
      // home: const LoginScreen(),
      home: const SelectRole(),
      routes: {
        '/select_action': (context) => const SelectActionScreen(),
        '/select_role': (context) => const SelectRole(),
        '/teacher_action': (context) => TeacherActions(),
      },
    );
  }
}
