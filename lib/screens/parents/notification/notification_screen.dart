import 'package:flutter/material.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/notification/notification_item.dart';
import 'package:project_sem4_flutter_app_mobile/screens/widgets/build_searchbox.dart';

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = 3;
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                          child: Text("A"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Thông báo",
                        style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              BuildSearchBox(),
            ])));
  }
}
