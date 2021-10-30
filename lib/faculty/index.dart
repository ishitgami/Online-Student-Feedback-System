import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../route.dart';
import 'addFeedbackClassScreen.dart';
import 'faculltyFClassScreen.dart';


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
                FirebaseFirestore.instance.clearPersistence();
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, loginScreenRoute);
              },
            )
          ]),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
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
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                      Spacer(),
                      IconButton(
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddFeedbackClassScreen(),
                                ));
                          },
                          icon: Icon(Icons.add))
                    ],
                  )),
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
                                          feedbackClassId:
                                              data[index]['name'].toString())),
                                );
                              },
                                leading: Icon(
                                  Icons.groups_outlined,
                                  size: 35,
                                  color: Colors.blueAccent,
                                ),
                                title: Text(data[index]['name'].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
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
                                    return Text('Created by' +
                                        ' ' +
                                        document['PersonalInfo']['First Name'] +
                                        ' ' +
                                        document['PersonalInfo']['Last Name']);
                                  },
                                ),
                              );
                            },
                          );
                        }
                        return Text('Its Error!');
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
