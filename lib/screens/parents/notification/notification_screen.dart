import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget{
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Search Screen"),
        Text("First section"),
        Text("notification section")
      ],
    );
  }
}