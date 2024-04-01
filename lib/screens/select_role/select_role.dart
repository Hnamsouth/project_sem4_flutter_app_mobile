import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/screens/widgets/select_direction.dart';
import 'package:quickly/quickly.dart';

class SelectRole extends StatelessWidget {
  const SelectRole({super.key});

  @override
  Widget build(BuildContext context) {
    var listSelectRole = [
      {
        "title": "I'm a teacher",
        "direction": "/teacher_action",
        "img": "https://robohash.org/Terry.png?set=set3"
      },
      {
        "title": "I'm a parent",
        "direction": "/teacher_action",
        "img": "https://robohash.org/Terry.png?set=set4"
      },
    ];

    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Select your role")
            .bold
            .fontSize(20)
            .pOnly(bottom: 20)
            .marginOnly(bottom: 40),
        ...listSelectRole.map((e) => SelectDirection(
              title: e["title"],
              direction: e["direction"],
              img: e["img"],
            )),
      ],
    )));
  }
}
