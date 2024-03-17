import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:rive/rive.dart';

class SelectActionScreen extends StatelessWidget {
  SelectActionScreen({super.key});

  final List<Map<String, dynamic>> listAction = [
    {
      'title': 'Manage School',
      'route': '/main',
    },
    {
      'title': 'Manage Student',
      'route': '/manage_student',
    },
    {
      'title': 'Manage Teacher',
      'route': '/manage_teacher',
    },
    {
      'title': 'Manage Class',
      'route': '/manage_class',
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
          child: Image.asset(
            "assets/Backgrounds/Spline.png",
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: const SizedBox(),
          ),
        ),
        const RiveAnimation.asset(
          "assets/RiveAssets/shapes.riv",
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
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            elevation: 5,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, e['route'].toString());
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
                  offset: const Offset(1, 2), // changes position of shadow
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
      ]),
    );
  }
}
