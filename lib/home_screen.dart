import 'package:flutter/material.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/chat/chat_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/contact/contact_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/home_parent.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/notification/notification_screen.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/work/work_screen.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();


}

class _HomeScreenState extends State<HomeScreen>{
  final List<Widget> _screens = [
    const HomeParent(),
    const ChatScreen(),
    const NotificationScreen(),
    const WorkScreen(),
    const ContactScreen(),

  ];
  int _selectedIndex = 0;

  _changeTab(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: primary,
        unselectedItemColor: secondary,
        onTap: (index) => _changeTab(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: "Trò chuyện"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active),label: "Thông Báo"),
          BottomNavigationBarItem(icon: Icon(Icons.lock_clock_outlined),label: "Hoạt động"),
          BottomNavigationBarItem(icon: Icon(Icons.contact_page),label: "Danh bạ"),
        ],
      ),
    );
  }
}