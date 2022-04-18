import 'package:flutter/material.dart';
import 'FacultyDrawer.dart';
import 'package:osfs1/presentation/router/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;

class FacultyDashbordScreen extends StatefulWidget {
  @override
  _FacultyDashbordScreenState createState() => _FacultyDashbordScreenState();
}

class _FacultyDashbordScreenState extends State<FacultyDashbordScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  var uid;
  int touchedIndex;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    uid = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: FacultyDrawer(),
        appBar: AppBar(title: Text('DashBoard'), actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseFirestore.instance.clearPersistence();
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, loginScreenRoute);
            },
          )
        ]),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  // width: 500,
                  // height: 200,
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.95 * 0.35,
                  padding: EdgeInsets.fromLTRB(10, 10, 40, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                          Text(
                            'Feedback\nClass',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        '5',
                        style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  // width: 500,
                  // height: 300,
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.95 * 0.90,
                  padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(35, 10, 0, 20),
                        child: Text(
                          'FeedbackClass Chart',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: BarChart(
                            BarChartData(
                              // maxY: 110,
                              titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) =>
                                        const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                  ),
                                  topTitles: SideTitles(showTitles: false),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) =>
                                        const TextStyle(
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    margin: 10),
                                bottomTitle: AxisTitle(
                                    showTitle: true,
                                    titleText: 'Feedback',
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    margin: 10),
                              ),
                              barGroups: getData(),
                            ),
                          ),
                        ),
                      ),
                      
                    ],
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
        x: 2,
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

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
