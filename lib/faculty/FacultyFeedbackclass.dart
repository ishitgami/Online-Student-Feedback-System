import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FacultyDrawer.dart';
import 'addFeedbackClass.dart';
import 'faculltyFClassScreen.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FacultyFclassScreen extends StatefulWidget {
  @override
  _FacultyFclassScreenState createState() => _FacultyFclassScreenState();
}

class _FacultyFclassScreenState extends State<FacultyFclassScreen> {
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
    return Scaffold(
      drawer: FacultyDrawer(),
      appBar: AppBar(
        title: Text('Feedback Class'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text(
                    'FeedbackClass',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  Spacer(),
                  IconButton(
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFeedbackClassScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 15,
              child: StreamBuilder(
                stream: firestore
                    .collection('FeedbackClass')
                    .where('Faculty', isEqualTo: uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> data =
                        snapshot.data.docs.map((e) => e.data()).toList();
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FaculltyFClassScreen(
                                  feedbackClassId: data[index]['Id'].toString(),
                                ),
                              ),
                            );
                          },
                          leading: Icon(
                            Icons.groups_outlined,
                            size: 35,
                            color: Colors.blueAccent,
                          ),
                          title: Text(
                            data[index]['name'].toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          subtitle: StreamBuilder(
                            stream: firestore
                                .collection('Users')
                                .doc(data[index]['Faculty'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              var document = snapshot.data;
                              String fName =
                                  document['PersonalInfo']['First Name'];
                              String lName =
                                  document['PersonalInfo']['Last Name'];
                              return Text(
                                  'Created by' + ' ' + fName + ' ' + lName);
                            },
                          ),
                        );
                      },
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
