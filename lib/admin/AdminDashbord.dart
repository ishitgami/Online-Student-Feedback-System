import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../route.dart';
import 'DrawerAdmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    
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
                        decoration: BoxDecoration(
                           color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Students',
                                style: TextStyle(
                                   color:  Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              StreamBuilder(
                                stream: firestore
                                    .collection('Users')
                                    .where('role', isEqualTo: 'student')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.docs.length.toString(),
                                      style: TextStyle(
                                          color:  Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
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
                        decoration: BoxDecoration(
                           color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Faculty',
                                style: TextStyle(
                                   color:  Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              StreamBuilder(
                                stream: firestore
                                    .collection('Users')
                                    .where('role', isEqualTo: 'faculty')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.docs.length.toString(),
                                      style: TextStyle(
                                          color:  Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                           color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
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


}
