import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'package:osfs1/presentation/router/route.dart';
import 'package:provider/provider.dart';
import 'DrawerAdmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  //Provider
  AdminProvider collegedata;

  var orgCode;
  var studentTotal;
  var facultyTotal;
  List departmentList;
  List acYearList;
  String _selectedAcYear;
  String _selectedDepartment;

  AdminData adminData;

  @override
  Widget build(BuildContext context) {
   collegedata =  Provider.of<AdminProvider>(context);

    collegedata.fetchAdminData().then((value) {
      setState(() {
      adminData = value;
      acYearList = adminData.acYear;
      departmentList = adminData.department;
      }); 
    });

    // collegedata.fetchAdminData11().then((value) => 
    // print(value)
    // );

   

    collegedata
        .getStudentTotal(adminData == null ? 0 : adminData.orgCode)
        .then((value) {
      studentTotal = value;
    });

    collegedata
        .getFacultyTotal(adminData == null ? 0 : adminData.orgCode)
        .then((value) {
      facultyTotal = value;
    });

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('DASHBORD'), actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            FirebaseFirestore.instance.clearPersistence();
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, loginScreenRoute);
          },
        )
      ]),
      drawer: AdminDrawer(),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         margin: EdgeInsets.fromLTRB(0, 8, 0, 12),
                  //         decoration: containerDecoration,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(12.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 'Organization\nCode',
                  //                 style: orgHeadingTextStyle,
                  //               ),
                  //               Text(
                  //                 adminData == null
                  //                     ? '0'
                  //                     : adminData
                  //                         .toJson()['orgCode']
                  //                         .toString(),
                                      
                  //                 style: orgDataTextStyle,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: adminContainer(
                            'Ac Year',
                            acYearList == null
                                ? 0
                                : acYearList.length.toString()),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: adminContainer(
                            'Department',
                            departmentList == null
                                ? 0
                                : adminData
                                    .toJson()['department']
                                    .length
                                    .toString()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: adminContainer('Faculty', facultyTotal),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: adminContainer('Student', studentTotal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                dropdownColor: Colors.grey[100],
                                iconEnabledColor: Colors.black,
                                hint: Text('Acedemic Year',
                                    style: TextStyle(
                                        color: Colors
                                            .black)), // Not necessary for Option 1
                                value: _selectedAcYear,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedAcYear = newValue;
                                  });
                                },
                                items: acYearList == null
                                    ? []
                                    : acYearList.map((acYear) {
                                        return DropdownMenuItem(
                                          child: new Text(acYear),
                                          value: acYear,
                                        );
                                      }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                dropdownColor: Colors.grey[100],
                                iconEnabledColor: Colors.black,
                                hint: Text('Department',
                                    style: TextStyle(
                                        color: Colors
                                            .black)), // Not necessary for Option 1
                                value: _selectedDepartment,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedDepartment = newValue;
                                  });
                                },
                                items: adminData == null
                                    ? []
                                    : departmentList.map((department) {
                                        return DropdownMenuItem(
                                          child: new Text(department),
                                          value: department,
                                        );
                                      }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: containerDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'FeedBackClass',
                                    style: orgHeadingTextStyle,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                '5',
                                style: containerHeadingStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   decoration: containerDecoration,
                  //   height: 300,
                  //   margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                  //   padding: EdgeInsets.all(15),
                  //   child: BarChart(
                  //     BarChartData(
                  //       // maxY: 110,
                  //       titlesData: FlTitlesData(
                  //           show: true,
                  //           bottomTitles: SideTitles(
                  //             showTitles: true,
                  //             getTextStyles: (context, value) =>
                  //                 const TextStyle(
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 10),
                  //           ),
                  //           topTitles: SideTitles(showTitles: false),
                  //           leftTitles: SideTitles(
                  //             showTitles: true,
                  //             getTextStyles: (context, value) =>
                  //                 const TextStyle(
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 10),
                  //           ),
                  //           rightTitles: SideTitles(showTitles: false)),
                  //       borderData: FlBorderData(
                  //         show: false,
                  //       ),

                  //       axisTitleData: FlAxisTitleData(
                  //         leftTitle: AxisTitle(
                  //             showTitle: true,
                  //             titleText: 'Students',
                  //             textStyle: TextStyle(
                  //                 fontSize: 13, fontWeight: FontWeight.bold),
                  //             margin: 10),
                  //         bottomTitle: AxisTitle(
                  //             showTitle: true,
                  //             titleText: 'Feedback',
                  //             textStyle: TextStyle(
                  //                 fontSize: 13, fontWeight: FontWeight.bold),
                  //             margin: 10),
                  //       ),
                  //       barGroups: getData(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container adminContainer(headerText, headerData) {
    return Container(
      decoration: containerDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              headerText,
              style: orgHeadingTextStyle,
            ),
            Text(
              headerData == null ? '0' : headerData.toString(),
              style: containerHeadingStyle,
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        showingTooltipIndicators: [1, 2, 3],
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 150,
              width: 20,
              rodStackItems: [
                BarChartRodStackItem(0, 150, Colors.blueAccent),
                BarChartRodStackItem(0, 110, Colors.blue[300]),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 140,
              width: 20,
              rodStackItems: [
                BarChartRodStackItem(0, 140, Colors.blueAccent),
                BarChartRodStackItem(0, 90, Colors.blue[300]),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              y: 160,
              width: 20,
              rodStackItems: [
                BarChartRodStackItem(0, 160, Colors.blueAccent),
                BarChartRodStackItem(0, 140, Colors.blue[300]),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 100,
              width: 20,
              rodStackItems: [
                BarChartRodStackItem(0, 100, Colors.blueAccent),
                BarChartRodStackItem(0, 90, Colors.blue[300]),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 130,
              width: 20,
              rodStackItems: [
                BarChartRodStackItem(0, 130, Colors.blueAccent),
                BarChartRodStackItem(0, 80, Colors.blue[300]),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
    ];
  }
}
