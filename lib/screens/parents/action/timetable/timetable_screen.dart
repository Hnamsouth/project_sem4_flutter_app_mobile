import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

List<Map<dynamic, dynamic>> _list = [
  {
    'thu': 2,
    'tiet_1': 'HĐTN',
    'tiet_2': 'Tiếng Anh',
    'tiet_3': 'Thư Viện',
    'tiet_4': 'Tiếng Anh',
    'color': HexColor("F4AFB0FF")

  },
  {
    'thu': 3,
    'tiet_1': 'HĐTN',
    'tiet_2': 'Tiếng Anh',
    'tiet_3': 'Thư Viện',
    'tiet_4': 'Tiếng Anh',
    'color': HexColor("8ECED7FF")

  },
  {
    'thu': 4,
    'tiet_1': 'HĐTN',
    'tiet_2': 'Tiếng Anh',
    'tiet_3': 'Thư Viện',
    'tiet_4': 'Tiếng Anh',
    'color': HexColor("8CB6D5FF")

  },
  {
    'thu': 5,
    'tiet_1': 'HĐTN',
    'tiet_2': 'Tiếng Anh',
    'tiet_3': 'Thư Viện',
    'tiet_4': 'Tiếng Anh',
    'color': HexColor("C4D39EFF")

  },
  {
    'thu': 6,
    'tiet_1': 'HĐTN',
    'tiet_2': 'Tiếng Anh',
    'tiet_3': 'Thư Viện',
    'tiet_4': 'Tiếng Anh',
    'color': HexColor("C28ED7FF")

  },
];

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Thời khoá biểu"),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: [
            ..._list
                .asMap()
                .map((key, e) => MapEntry(
                    key,
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(20),

                          color: e['color']
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Thứ " + e['thu'].toString() ?? "",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25,
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                  )
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            
                            Center(
                              child: Column(
                                children: [
                                  Row(children: [
                                    Text(
                                      e['tiet_1'] ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    Text(
                                      e['tiet_2'] ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    Text(
                                      e['tiet_3'] ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    Text(
                                      e['tiet_4'] ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                ],
                              ),
                            )
                           
                          ],
                        ),
                      ),
                    ))
                .values
          ],
        ));
  }
}
