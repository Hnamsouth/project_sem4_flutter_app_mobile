// import 'package:flutter/material.dart';
// import 'package:project_sem4_flutter_app_mobile/provider/theme_provider.dart';
// import 'package:project_sem4_flutter_app_mobile/screens/widgets/circle_avatar.dart';
// import 'package:project_sem4_flutter_app_mobile/screens/widgets/data_table_demo.dart';
// import 'package:project_sem4_flutter_app_mobile/screens/widgets/side_menu.dart';
// import 'package:provider/provider.dart';
//
// class MainScreen extends StatefulWidget {
//   final Map<String, dynamic> action;
//   const MainScreen({super.key, required this.action});
//   @override
//   State<MainScreen> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MainScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: const SideMenuWidget(),
//         body: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               floating: true,
//               scrolledUnderElevation: 0,
//               pinned: true,
//               actions: _actionAppbar,
//             ),
//             const SliverToBoxAdapter(
//               child: DemoDataTable(),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   return ListTile(
//                     title: Text('Item #$index'),
//                   );
//                 },
//                 childCount: 20,
//               ),
//             ),
//           ],
//         ));
//   }
//
//   List<Widget> get _actionAppbar => [
//         // notification
//         Stack(
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.notifications,
//                 color: Theme.of(context).colorScheme.onPrimary,
//                 size: 35,
//               ),
//             ),
//             Positioned(
//               right: 7,
//               top: 7,
//               child: Container(
//                 width: 18,
//                 height: 18,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Theme.of(context).colorScheme.background,
//                     width: 1,
//                   ),
//                 ),
//                 child: const Text(
//                   '9',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 11,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         const SizedBox(width: 10),
//         // admin info
//         Row(
//           children: [
//             CircleAvatarWithBorderWidget(
//               width: 30,
//               height: 30,
//               image: 'assets/Backgrounds/Spline.png',
//             ),
//             const SizedBox(width: 10),
//             Text(
//               'Admin',
//               style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
//             ),
//           ],
//         ),
//         const SizedBox(width: 10),
//         // popup menu
//         PopupMenuButton(
//           surfaceTintColor: Theme.of(context).colorScheme.onSecondary,
//           padding: EdgeInsets.zero,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           itemBuilder: (BuildContext context) => <PopupMenuEntry>[
//             PopupMenuItem(
//               onTap: () {
//                 // like context.read<ThemeProvider>().changeTheme();
//                 Provider.of<ThemeProvider>(context, listen: false)
//                     .changeTheme();
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 child: Row(
//                   children: [
//                     Icon(Icons.brightness_4_outlined,
//                         color: Theme.of(context).colorScheme.onPrimary),
//                     const SizedBox(width: 10),
//                     Text('Change Theme',
//                         style: TextStyle(
//                             color: Theme.of(context).colorScheme.onPrimary)),
//                   ],
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               onTap: () {
//                 // like context.read<ThemeProvider>().changeTheme();
//                 Provider.of<ThemeProvider>(context, listen: false)
//                     .changeTheme();
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 child: Row(
//                   children: [
//                     Icon(Icons.settings_outlined,
//                         color: Theme.of(context).colorScheme.onPrimary),
//                     const SizedBox(width: 10),
//                     Text('Setting',
//                         style: TextStyle(
//                             color: Theme.of(context).colorScheme.onPrimary)),
//                   ],
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               onTap: () {
//                 Future.delayed(const Duration(milliseconds: 300), () {
//                   Navigator.pop(context);
//                 });
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 child: Row(
//                   children: [
//                     Icon(Icons.arrow_back_rounded,
//                         color: Theme.of(context).colorScheme.onPrimary),
//                     const SizedBox(width: 10),
//                     Text('Go Back',
//                         style: TextStyle(
//                             color: Theme.of(context).colorScheme.onPrimary)),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ];
// }
