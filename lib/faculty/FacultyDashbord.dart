import 'package:flutter/material.dart';
import 'FacultyDrawer.dart';
import 'package:osfs1/route.dart';
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

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    uid = user.uid;
  }
  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 0.0;
    const yearTextStyle =
    TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold);
    return Scaffold(
      drawer: FacultyDrawer(),
      appBar: AppBar(
          title: Text('DashBoard'),
          actions: <Widget>[
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
      body: SizedBox(
      width: 330,
      height: 180,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(1, 1),
                FlSpot(2, 3),
                FlSpot(3, 3),
                FlSpot(4, 5),
                FlSpot(4, 4)
              ],
              isCurved: false,
              barWidth: 1,
              colors: [
                Colors.black,
              ],
              belowBarData: BarAreaData(
                show: true,
                colors: [Colors.lightGreen.withOpacity(0.4)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              aboveBarData: BarAreaData(
                show: true,
                colors: [Colors.red.withOpacity(0.6)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 6,
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '2015';
                    case 1:
                      return '2016';
                    case 2:
                      return '2017';
                    case 3:
                      return '2018';
                    case 4:
                      return '2019';
                    default:
                      return '';
                  }
                }),
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return '\$ ${value + 20}';
              },
            ),
          ),
          axisTitleData: FlAxisTitleData(
              leftTitle: AxisTitle(showTitle: true, titleText: 'Value', margin: 10),
              bottomTitle: AxisTitle(
                  showTitle: true,
                  margin: 10,
                  titleText: 'Year',
                  textStyle: yearTextStyle,
                  textAlign: TextAlign.right)),
          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (double value) {
              return value == 1 || value == 2 || value == 3 || value == 4;
            },
          ),
        ),
      ),
    )
    );
  }
}



