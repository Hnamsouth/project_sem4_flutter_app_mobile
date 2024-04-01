import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/screens/action_type.dart';
import 'package:project_sem4_flutter_app_mobile/screens/auth/login/login_screen.dart';
import 'package:rive/rive.dart';

import 'main_screen.dart';

class SelectActionScreen extends StatelessWidget {
  SelectActionScreen({super.key});

  final List<Map<String, dynamic>> listAction = [
    {
      'title': 'Giáo Viên',
      'type': ActionType.MANAGER_TEACHER,
    },
    {
      'title': 'Phụ Huynh',
      'type': ActionType.MANAGER_PARENT,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 200,
            bottom: 0,
            child: Text("")),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: const SizedBox(),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: const SizedBox(),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: GridView.count(
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.all(defaultPadding + 15),
                crossAxisSpacing: defaultPadding + 15,
                mainAxisSpacing: defaultPadding + 15,
                crossAxisCount: 2,
                children: [
                  // ..._buildGridTileList(context),
                  ...listAction
                      .asMap()
                      .map((i, e) => MapEntry(
                          i,
                          FloatingActionButton(
                            heroTag: e['title'].toString(),
                            backgroundColor: Colors.black,
                            elevation: 5,
                            onPressed: () {
                              // Navigator.pushNamed(
                              //     context, e['route'].toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              e['title'].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.8,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          )))
                      .values
                ])),
      ]),
    );
  }
}
