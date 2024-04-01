import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../service/user_service.dart';

class HomeParent extends StatefulWidget {
  const HomeParent({super.key});

  @override
  State<HomeParent> createState() => _HomeParentState();
}

final _controller = PageController();

class _HomeParentState extends State<HomeParent> {
  @override
  Widget build(BuildContext context) {
    void _logout() {
      Navigator.pushNamed(context, '/login');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            // scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Row(
                  children: [
                    SizedBox(
                      height: 100,
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                        child: Text('A'),
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
                    const Text(
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
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 40),
                          crossAxisCount: 3,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 40,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Ink(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        color: Colors.deepOrange,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: const FaIcon(
                                          FontAwesomeIcons.graduationCap,
                                          size: 43.0),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(
                                      FontAwesomeIcons.schoolCircleCheck,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(
                                      FontAwesomeIcons.calendarDays,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(
                                      FontAwesomeIcons.calendarDay,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(FontAwesomeIcons.bookOpen,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(FontAwesomeIcons.calendar,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 40),
                          crossAxisCount: 3,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 40,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Ink(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: const FaIcon(
                                          FontAwesomeIcons.calendarDays,
                                          size: 43.0),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(FontAwesomeIcons.bowlRice,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(
                                      FontAwesomeIcons.addressCard,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(
                                      FontAwesomeIcons.usersRectangle,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(FontAwesomeIcons.qrcode,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const FaIcon(FontAwesomeIcons.globe,
                                      size: 45.0),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
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
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 40),
                          crossAxisCount: 3,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 40,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Ink(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        color: Colors.pink,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: const FaIcon(FontAwesomeIcons.heart,
                                          size: 44.0),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
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
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/B_Ill_Education_Back_to_school_min_a72a89f00f.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: null,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
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
                          offset:
                              const Offset(1, 2), // changes position of shadow
                        )
                      ],
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await UserService.logout();
                        Logger().i("Logout Success");
                        _logout();
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
          )
        ],
      ),
    );
  }
}
