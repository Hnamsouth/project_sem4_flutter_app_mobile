import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_sem4_flutter_app_mobile/screens/parents/action/attendance/take_leave.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Điểm danh,Xin nghỉ học",style: TextStyle(
          fontSize: 20
        ),),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),


        child: Column(
          children: [
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              ],

            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Container(
                  height: 65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("3"),
                          Text("Có Phép"),

                        ],
                      ),
                      Column(
                        children: [
                          Text("3"),
                          Text("Không Phép"),

                        ],
                      ),
                      Column(
                        children: [
                          Text("3"),
                          Text("Vào muộn"),

                        ],

                      ),
                      Column(
                        children:[
                          TextButton(
                            style: ButtonStyle(

                              // backgroundColor: MaterialStatePropertyAll<Color>(HexColor("#")),
                            ),
                            onPressed: () {
                              Get.to(TakeLeaveScreen());
                            },
                            child: const Text("Xin Nghỉ Học",)),
      ]
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),

      ) ,
    );
  }
}
