import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeParent extends StatefulWidget {
  const HomeParent({super.key});

  @override
  State<HomeParent> createState() => _HomeParentState();
}

final _controller = PageController();

class _HomeParentState extends State<HomeParent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            // scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 100,
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                          child: const Text('A'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "eNetViet",
                        style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Các chức năng",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Text("Tất Cả"))
                    ],
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  SizedBox(
                    height: 320,
                    child: PageView(
                      controller: _controller,
                      children: [
                        Container(
                          child: GridView.count(
                            childAspectRatio: 6 / 7,
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
                            crossAxisCount: 3,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 40,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Ink(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: Colors.deepOrange,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: FaIcon(
                                            FontAwesomeIcons.graduationCap,
                                            size: 43.0),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Học phí,Khoản thu",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.purple,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(
                                        FontAwesomeIcons.schoolCircleCheck,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Điểm danh,Xin nghỉ học",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.pink,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.calendarDays,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Hoạt động hàng ngày",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.deepOrange,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.calendarDay,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Phiếu đánh giá học tập",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.deepOrange,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.bookOpen,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Nhiệm vụ,Bài tập",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.calendar,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Đăng ký, Khảo sát",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                            ],
                          ),
                        ),
                        Container(
                          child: GridView.count(
                            childAspectRatio: 6 / 7,
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
                            crossAxisCount: 3,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 40,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Ink(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: FaIcon(
                                            FontAwesomeIcons.calendarDays,
                                            size: 43.0),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Thời khoá biểu lớp học",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.pink,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.bowlRice,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Thực đơn bữa ăn",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.addressCard,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Thông tin học sinh",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.purple,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(

                                    color: Colors.white,
                                    icon: FaIcon(
                                        FontAwesomeIcons.usersRectangle,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Trang số liệu học",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.qrcode,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Quét QR code",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                              Column(children: [
                                Ink(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.globe,
                                        size: 45.0),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Trang điện Tử",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                            ],
                          ),
                        ),
                        Container(
                          child: GridView.count(
                            childAspectRatio: 6 / 7,
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
                            crossAxisCount: 3,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 40,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Ink(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: FaIcon(FontAwesomeIcons.heart,
                                            size: 44.0),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Thời khoá biểu lớp học",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                              // Column(children: [
                              //   Ink(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         5, 5, 5, 5),
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.green),
                              //         color: Color.fromRGBO(128, 215, 255, 1),
                              //         borderRadius:
                              //         BorderRadius.circular(20.0)),
                              //     child: IconButton(
                              //       color: Colors.white,
                              //       icon: FaIcon(FontAwesomeIcons., size: 45.0),
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              //   SizedBox(
                              //     height: 3,
                              //   ),
                              //   Text(
                              //     "Thực đơn bữa ăn",
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   )
                              // ]),
                              // Column(children: [
                              //   Ink(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         5, 5, 5, 5),
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.green),
                              //         color: Color.fromRGBO(128, 215, 255, 1),
                              //         borderRadius:
                              //         BorderRadius.circular(20.0)),
                              //     child: IconButton(
                              //       color: Colors.white,
                              //       icon: FaIcon(FontAwesomeIcons., size: 45.0),
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              //   SizedBox(
                              //     height: 3,
                              //   ),
                              //   Text(
                              //     "Thông tin học sinh",
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   )
                              // ]),
                              // Column(children: [
                              //   Ink(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         5, 5, 5, 5),
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.green),
                              //         color: Color.fromRGBO(128, 215, 255, 1),
                              //         borderRadius:
                              //         BorderRadius.circular(20.0)),
                              //     child: IconButton(
                              //       color: Colors.white,
                              //       icon: FaIcon(FontAwesomeIcons., size: 45.0),
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              //   SizedBox(
                              //     height: 3,
                              //   ),
                              //   Text(
                              //     "Trang số liệu học",
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   )
                              // ]),
                              // Column(children: [
                              //   Ink(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         5, 5, 5, 5),
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.green),
                              //         color: Color.fromRGBO(128, 215, 255, 1),
                              //         borderRadius:
                              //         BorderRadius.circular(20.0)),
                              //     child: IconButton(
                              //       color: Colors.white,
                              //       icon: FaIcon(FontAwesomeIcons., size: 45.0),
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              //   SizedBox(
                              //     height: 3,
                              //   ),
                              //   Text(
                              //     "Quét QR code",
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   )
                              // ]),
                              // Column(children: [
                              //   Ink(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         5, 5, 5, 5),
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.green),
                              //         color: Color.fromRGBO(128, 215, 255, 1),
                              //         borderRadius:
                              //         BorderRadius.circular(20.0)),
                              //     child: IconButton(
                              //       color: Colors.white,
                              //       icon: FaIcon(FontAwesomeIcons., size: 45.0),
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              //   SizedBox(
                              //     height: 3,
                              //   ),
                              //   Text(
                              //     "Trang điện Tử",
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   )
                              // ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const SlideEffect(
                      activeDotColor: Colors.white54,
                      dotHeight: 10,
                      dotColor: Colors.blue,
                      dotWidth: 10,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/B_Ill_Education_Back_to_school_min_a72a89f00f.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: null,
                      )),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tin tức - Sự kiện",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Text("Tất Cả"))
                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.only(left: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.onSecondary,
                            blurRadius: 3,
                            offset: const Offset(
                                1, 2), // changes position of shadow
                          )
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.onPrimary,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  )



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
