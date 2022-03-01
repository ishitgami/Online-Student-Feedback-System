import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';


class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User user;
  var uid;
  var totalStudent=0;

  var userdataList = <Map>[];
  var data;
  List<bool> _isChecked;
  bool checkListBool = true;
  List studentUIdList = [];
  String feedbackClassName;

  void updateFeedbackClass(element,feedbackClassId) {
    firestore.collection('Users').doc(element).update({
                        'FeedbackClass': FieldValue.arrayUnion([feedbackClassId]),
                      });
  }

  String genrateFeedbackClassId() {
    return randomAlphaNumeric(20);
  }


  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    uid = user.uid;

    _isChecked = List<bool>.filled(userdataList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                      'Add Students',
                      style: TextStyle(fontSize: 30,color: Colors.blueAccent, fontWeight: FontWeight.w800),
                ),
                Spacer(),
                Icon(Icons.filter_alt_outlined,size: 35,color: Colors.blueAccent,)
                    ],
                  ),
                
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: StreamBuilder(
                  stream: firestore
                      .collection('Users')
                      .where('role', isEqualTo: 'student')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data.docs;
                      List<dynamic> data =
                          snapshot.data.docs.map((e) => e.data()).toList();

                      if (checkListBool) {
                        _isChecked = List<bool>.filled(documents.length, false);
                        checkListBool = false;
                      }

                      return ListView.separated(
                        separatorBuilder: (context, index) {
                              return Divider();
                            },
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            value: _isChecked[index],
                            onChanged: (bool value) {
                              setState(() {
                                if (_isChecked[index] == false) {
                                  totalStudent++;
                                  studentUIdList
                                      .add(data[index]['PersonalInfo']['UId']);
                                } else {
                                  totalStudent--;
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Back",style: TextStyle(color: Colors.white),),
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        String feedbackClassId = genrateFeedbackClassId();
                        print('FeedbackClassId-->$feedbackClassId');
                        firestore.collection('FeedbackClass').doc(feedbackClassId).set({
                          'StudentList': FieldValue.arrayUnion(studentUIdList),
                          'Faculty': '$uid',
                          'name' : '$feedbackClassName',
                          'Id' : '$feedbackClassId',
                        });
                        studentUIdList.forEach((element) {
                          updateFeedbackClass(element,feedbackClassId);
                        });
                        Navigator.pop(context);
                      },
                      child: Text("ADD ($totalStudent)",style: TextStyle(color: Colors.white)),
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
