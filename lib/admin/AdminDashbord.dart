import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:osfs1/Model/admin-model.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../route.dart';
import 'DrawerAdmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminModel adminModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User loggedInUser;
  var orgCode;
  var studentTotal;
  var facultyTotal;
  List<String> _locations = [
    '2018-2022',
    '2019-2023',
    '2020-2024',
    '2021-2025'
  ]; // Option 2
  String _selectedLocation; // Option 2
  @override
  Widget build(BuildContext context) {
    adminModel = Provider.of<AdminModel>(context);
    loggedInUser = adminModel.getCurrentUser();

    adminModel.getOrgCode(loggedInUser.uid).then((value) {
      setState(() {
        orgCode = value;
      });
    });

    adminModel.getStudentTotal(orgCode).then((value) {
      setState(() {
        studentTotal = value;
      });
    });

    adminModel.getFacultyTotal(orgCode).then((value) {
      setState(() {
        facultyTotal = value;
      });
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 8, 0, 12),
                        decoration: containerDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Organization\nCode',
                                style: orgHeadingTextStyle,
                              ),
                              Text(
                                orgCode == null ? '0' : orgCode.toString(),
                                style: orgDataTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: containerDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Department',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '7',
                                style: containerHeadingStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: containerDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Faculty',
                                style: orgHeadingTextStyle,
                              ),
                              Text(
                                facultyTotal == null
                                    ? '0'
                                    : facultyTotal.toString(),
                                style: containerHeadingStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                       Icon(
                  Icons.filter_alt_outlined,
                  size: 35,
                  color: Colors.black,
                ),
                Spacer(),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconEnabledColor: Colors.black,
                          hint: Text(
                              'Please choose Ac Year'), // Not necessary for Option 1
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLocation = newValue;
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: containerDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Students',
                                style: orgHeadingTextStyle,
                              ),
                              Text(
                                studentTotal == null
                                    ? '0'
                                    : studentTotal.toString(),
                                style: containerHeadingStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: containerDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'FeedBackClass',
                                style: orgHeadingTextStyle,
                              ),
                              Text(
                                '5',
                                style: containerHeadingStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: containerDecoration,
                  height: 300,
                  margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                  padding: EdgeInsets.all(15),
                  child: BarChart(
                    BarChartData(
                      // maxY: 110,
                      titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          topTitles: SideTitles(showTitles: false),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          rightTitles: SideTitles(showTitles: false)),
                      borderData: FlBorderData(
                        show: false,
                      ),

                      axisTitleData: FlAxisTitleData(
                        leftTitle: AxisTitle(
                            showTitle: true,
                            titleText: 'Students',
                            textStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                            margin: 10),
                        bottomTitle: AxisTitle(
                            showTitle: true,
                            titleText: 'Feedback',
                            textStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                            margin: 10),
                      ),
                      barGroups: getData(),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
