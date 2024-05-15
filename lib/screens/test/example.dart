// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// class MyRealtimeApp extends StatefulWidget {
//   const MyRealtimeApp({super.key});
//
//   @override
//   _MyRealtimeAppState createState() => _MyRealtimeAppState();
// }
//
// class _MyRealtimeAppState extends State<MyRealtimeApp> {
//   late WebSocketChannel channel;
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     channel = WebSocketChannel.connect(Uri.parse('ws://localhost:51606'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Realtime App'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Form(
//             child: TextFormField(
//               controller: _controller,
//               decoration: InputDecoration(labelText: 'Send a message'),
//             ),
//           ),
//           StreamBuilder(
//             stream: channel.stream,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data);
//               } else {
//                 return Text('No data');
//               }
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: Icon(Icons.send),
//       ),
//     );
//   }
//
//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       channel.sink.add(_controller.text);
//     }
//   }
//
//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }
// }
