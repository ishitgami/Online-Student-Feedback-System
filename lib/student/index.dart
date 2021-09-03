import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/constant.dart';
import '../route.dart';
import 'feedbackScreen.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class StudentScreen extends StatefulWidget {

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  var uid;
  var studentMap = <Map>[];
  List<dynamic> subjectFeedbackId;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    uid = user.uid;
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    await firestore.collection('user').doc(uid).get().then((value) => {
          valueData = value.data(),
          currentAcademicYearId = valueData['academicId'],
          currentDepartmentId = valueData['departmentId'],
          currentDivisionId = valueData['divisionId'],
          currentStudentId = valueData['userId'],
        });
    getCurrentUserData();
  }

  Future getCurrentUserData() async {
    try {
      if (user != null) {
        await firestore
            .collection('Academic Year')
            .doc(currentAcademicYearId)
            .collection('Department')
            .doc(currentDepartmentId)
            .collection('Division')
            .doc(currentDivisionId)
            .collection('Students')
            .doc(currentStudentId)
            .get()
            .then((value) => {
                  studentData = value.data(),
                  studentMap.add({
                    'FirstName': studentData['First Name'],
                    'MiddleName': studentData['Middle Name'],
                    'LastName': studentData['Last Name'],
                    'Email': studentData['Email'],
                    'Enrolment': studentData['Enrollment No'],
                  }),
                });
      }
    } catch (e) {
      print(e);
    }
    return studentMap;
  }

  Future getFeedback() async {
    subjectFeedbackId = [];
    await firestore
        .collection('Academic Year')
        .doc(currentAcademicYearId)
        .collection('Department')
        .doc(currentDepartmentId)
        .collection('Division')
        .doc(currentDivisionId)
        .collection('feedback')
        .where('submitted.' + uid, isEqualTo: false)
        .get()
        .then((value) => {
       
              value.docs.forEach((element) {
                if (element.exists) {
                  // setState(() {
                  currentFacultyId = element['FId'];
                  subjectFeedbackId.add(element.id);
                  // });
                }
              })
            });

    return subjectFeedbackId;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
         automaticallyImplyLeading: false,
          actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.logout,
        color: Colors.white,
      ),
      onPressed: () {
        DropdownButton(
          items: [

          ],
        );
        Navigator.pushNamed(context, loginScreenRoute);
      },
    )
  ],
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
            child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                  future: getFeedback(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: subjectFeedbackId.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FeedbackScreen(
                                        feedbackId: subjectFeedbackId[index],
                                        currentAcademicYearId: currentAcademicYearId,
                                        currentDepartmentId: currentDepartmentId,
                                        currentDivisionId: currentDivisionId,
                                        currentStudentId: uid,
                                      ),
                                    ),
                                  );

                                },
                                child: Card(
                                  color: Colors.grey[400],
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(subjectFeedbackId[index]),
                                  ),
                                ),
                              );
                            });
                      }
                    }
                    return Container();
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
