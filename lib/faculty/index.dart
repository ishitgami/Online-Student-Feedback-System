import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/auth/login.dart';
import 'package:osfs1/components/simpleDropdown.dart';
import 'package:osfs1/constant.dart';
import 'package:osfs1/getData/getFeedbackByFaculty.dart';
import 'package:osfs1/getData/getFeedbackQueByFaculty.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FacultyScreen extends StatefulWidget {
  static String id = 'Faculty screen';
  @override
  _FacultyScreenState createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  var uid;
  List<dynamic> ratingList;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    uid = user.uid;
    getFeedbackData();
  }

  Future getFeedbackData() async {
    feedbackList = [];
    await FeedbackDataByFaculty(currentFacultyId: uid)
        .getFeedbackByFaculty()
        .then((value) => {
          setState(() {
              feedbackList = value;
              })
            });
  }

  Future getFeedbackque() async {
    feedbackQueByDivisionMap = [];
    await GetQuewithRatingForFaculty(
            currentFacultyId: uid, feedbackId: currentFeedbackValue)
        .getQuewithRatingForFacultyData()
        .then((value) => {
              // setState(() {
              feedbackQueByDivisionMap = value,
              // })
            });
    return feedbackQueByDivisionMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
        automaticallyImplyLeading: false,
          actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.logout,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pushNamed(context, LoginScreen.id);
      },
    )
  ]
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                simpleDropdown(currentFeedbackValue, feedbackList, 'choose Class',
                    (value) {
                  setState(() {
                    currentFeedbackValue = value;
                    getFeedbackque();
                  });
                }),
                FutureBuilder(
                  future: getFeedbackque(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: feedbackQueByDivisionMap.length,
                          itemBuilder: (context, index) {
                            Map ratingmap = Map();
                            ratingmap = feedbackQueByDivisionMap[index]['rating'];
                            var rating = ratingmap.values;
                            var result =
                            rating.reduce((sum, element) => sum + element) /ratingmap.length;
                                    result = result.toStringAsFixed(2);
                            return Card(
                              margin: EdgeInsets.all(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            feedbackQueByDivisionMap[index]
                                                    ['question']
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      result.toString() == null
                                                          ? 'not rare yet'
                                                          : result.toString(),
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    Icon(Icons.star),     
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                'Total Student = '+ ratingmap.length.toString(),
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ],
            )),
      ),
    );
  }
}