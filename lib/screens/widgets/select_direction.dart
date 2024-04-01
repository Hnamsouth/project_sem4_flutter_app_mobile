import 'package:flutter/material.dart';
import 'package:project_sem4_flutter_app_mobile/model/user_model.dart';
import 'package:project_sem4_flutter_app_mobile/service/user_service.dart';
import 'package:quickly/quickly.dart';
import 'package:logger/logger.dart';

class SelectDirection extends StatelessWidget {
  final String? title;
  final String? direction;
  final String? img;
  const SelectDirection(
      {super.key,
      required this.title,
      required this.direction,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Colors.grey.shade300, width: 2, style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0.0, 3), //(x,y)
              blurRadius: 1.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: CircleAvatar(
                // backgroundImage: AssetImage(img),
                backgroundImage: NetworkImage(img!),
                radius: 50,
                backgroundColor: Colors.transparent,
              )),
          Expanded(
              flex: 3, child: Text(title!).fontSize(20).bold.pOnly(left: 10)),
          Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ))
        ],
      ),
    ).onTap(() {
      UserService.login();
      // Logger().i("Navigate to $direction");
      // Navigator.pushNamed(context, direction!);
    });
  }
}
