import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/components/simpleDropdown.dart';
import 'package:osfs1/constant.dart';
import 'package:random_string/random_string.dart';
import '../route.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FacultyScreen extends StatefulWidget {
  @override
  _FacultyScreenState createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  var uid;

  var userdataList = <Map>[];
  var data;
  List<bool> _isChecked;
  bool checkListBool = true;
  List studentUIdList = [];

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    uid = user.uid;

    _isChecked = List<bool>.filled(userdataList.length, false);
  }

  getStudentDataFromUsers() async {
    userdataList = <Map>[];
    await firestore
        .collection('Users')
        // .where('CollegeData.AcademicYear', isEqualTo: selectedYear)
        // .where('CollegeData.Department', isEqualTo: selectedDepartment)
        .get()
        .then((QuerySnapshot<Object> value) => {
              value.docs.forEach((DocumentSnapshot docs) {
                if (docs.exists) {
                  data = docs.data();
                  userdataList.add(data['PersonalInfo']);
                }
              }),
            });
    return userdataList;
  }

  void updateFeedbackClass(element,feedbackClassId) {
    firestore.collection('Users').doc(element).update({
                        'FeedbackClass': FieldValue.arrayUnion([feedbackClassId]),
                      });
  }

  String genrateFeedbackClassId() {
    return randomAlphaNumeric(20);
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
                Navigator.pushNamed(context, loginScreenRoute);
              },
            )
          ]),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: StreamBuilder(
                    stream: firestore.collection('Users').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        List<dynamic> data =
                            snapshot.data.docs.map((e) => e.data()).toList();

                        if (checkListBool) {
                          _isChecked =
                              List<bool>.filled(documents.length, false);
                          checkListBool = false;
                        }

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              value: _isChecked[index],
                              onChanged: (bool value) {
                                setState(() {
                                  if (_isChecked[index] == false) {
                                    studentUIdList.add(
                                        data[index]['PersonalInfo']['UId']);
                                  } else {
                                    studentUIdList.remove(
                                        data[index]['PersonalInfo']['UId']);
                                  }
                                  _isChecked[index] = value;
                                });
                              },
                              title: Text(
                                  data[index]['PersonalInfo']['Enrollment No']),
                              subtitle:
                                  Text(data[index]['PersonalInfo']['Email']),
                            );
                          },
                        );
                      }
                      return Text('Its Error!');
                    }),
              ),
              Expanded(
                flex: 1,
                child: MaterialButton(
                  onPressed: () {
                    String feedbackClassId = genrateFeedbackClassId();
                    print('FeedbackClassId-->$feedbackClassId');
                    firestore.collection('FeedbackClass').doc(feedbackClassId).set({
                      'StudentList': FieldValue.arrayUnion(studentUIdList),
                      'Faculty': '$uid',
                    });
                    studentUIdList.forEach((element) {
                      updateFeedbackClass(element,feedbackClassId);
                    });
                    
                  },
                  child: Text("ADD"),
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
