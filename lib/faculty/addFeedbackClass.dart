import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';


class AddFeedbackClassScreen extends StatefulWidget {
  @override
  _AddFeedbackClassScreenState createState() => _AddFeedbackClassScreenState();
}

class _AddFeedbackClassScreenState extends State<AddFeedbackClassScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User user;
  var uid;

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
                  Text(
                  'Add FeedbackClass',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
                  TextField(
                    onChanged: (value) {
                      feedbackClassName = value;
                    },
                    decoration : InputDecoration(
                      label: Text('FeedbackClass Name'),
                    )
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
                                  studentUIdList
                                      .add(data[index]['PersonalInfo']['UId']);
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
                        });
                        studentUIdList.forEach((element) {
                          updateFeedbackClass(element,feedbackClassId);
                        });
                        Navigator.pop(context);
                      },
                      child: Text("ADD",style: TextStyle(color: Colors.white)),
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
