import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Jonathan Cole is now following you.",
      "subtitle": "8 mins ago",
      "isNew": true,
      "isRead": false,
    },
    {
      "title": "Diane Guzman liked your post.",
      "subtitle": "5 hrs ago",
      "isNew": true,
      "isRead": false,
    },
    // Add more notifications here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Slidable(
            key: ValueKey(index),
            endActionPane: ActionPane(
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      notifications[index]['isRead'] = true;
                    });
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.done,
                  label: 'Mark as Read',
                ),
              ],
            ),
            child: Card(
              child: Container(
                color: notification['isRead'] ? Colors.grey[200] : Colors.cyan,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.notifications),
                  ),
                  title: Text(notification['title']),
                  subtitle: Text(notification['subtitle']),
                  trailing: notification['isNew']
                      ? Icon(Icons.fiber_new, color: Colors.red)
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
