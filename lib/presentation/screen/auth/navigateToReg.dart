import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osfs1/commanWidget/bottemWave.dart';
import 'package:osfs1/presentation/router/route.dart';

class NavigateToDiffReg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BottomWave(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 8),
                        color: Colors.blueAccent,
                        height: 145.0,
                        width: 10.0,
                      ),
                      Container(
                        // height: 115,
                        margin: EdgeInsets.only(left: 20, top: 8),
                        child: Text(
                          'ONLINE\nSTUDENT\nFEEDBACK\nSYSTEM',
                          style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, orgRegistrationRoute);
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.fromLTRB(40, 70, 40, 15),
                  //     padding: EdgeInsets.fromLTRB(85, 20, 85, 20),
                  //     decoration: BoxDecoration(
                  //       color: Colors.blueAccent[200],
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey,
                  //           blurRadius: 7.0,
                  //         ),
                  //       ],
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           FontAwesomeIcons.city,
                  //           size: 25,
                  //           color: Colors.white,
                  //         ),
                  //         SizedBox(
                  //           height: 7,
                  //         ),
                  //         Text(
                  //           'Organization',
                  //           style: TextStyle(
                  //               fontSize: 20,
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w700),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, facultyRegRoute);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40, 30, 40, 15),
                      padding: EdgeInsets.fromLTRB(110, 20, 110, 20),
                      decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 7.0,
                          ),
                        ],
                        color: Colors.blueAccent[200],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            FontAwesomeIcons.chalkboardTeacher,
                            size: 25,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Faculty',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, studentRegScreenRoute);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40, 30, 40, 15),
                      padding: EdgeInsets.fromLTRB(110, 20, 110, 20),
                      decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 7.0,
                          ),
                        ],
                        color: Colors.blueAccent[200],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            FontAwesomeIcons.userGraduate,
                            size: 25,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Student',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
