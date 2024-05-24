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
      appBar: AppBar(
        title: Text("Thông báo"),
      ),
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.insert_drive_file, size: 50),
                      Text('Chưa có dữ liệu.'),
                    ],
                  ),
                ),
              ),

            ],
          )

        )
    );
  }
}
