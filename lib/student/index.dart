import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../route.dart';
import 'feedbackScreen.dart';
import '../constant.dart';
import 'feedbackClassScreen.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class StudentScreen extends StatefulWidget {

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  List feedbackIdList = [];
  var userdataList = <Map>[];
  var data;
  var feedbackClassData;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    uid = user.uid;
}


getStudentDataFromUsers() async {
    userdataList = <Map>[];
    await firestore
        .collection('Users')
        .doc(uid)
        .get()
        .then((documentSnapshot) {
        data = documentSnapshot.data();
        feedbackIdList = data['FeedbackClass'];
          // print(data);
        }
        );
    return feedbackIdList;
  }

  getFeedbackClass() {
    //  print('feedbackIdList--->$feedbackIdList');
    feedbackIdList.forEach((element) {
      // print('element--->$element');
      firestore.collection('FeedbackClass')
      .doc(element)
      .get()
      .then((value) {
        feedbackClassData = value.data();
        print(feedbackClassData['name']);
      });
    });
    return feedbackClassData;
  }

  

  Future getCurrentUserData() async {
    try {
      
    } catch (e) {
      print(e);
    }
    return studentMap;
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
                Expanded(
                  child: StreamBuilder(
                    stream: firestore.collection('FeedbackClass').where('StudentList',arrayContains: uid).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        List<dynamic> data =
                            snapshot.data.docs.map((e) => e.data()).toList();
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            print(data[index]['Id']);
                            return ListTile(
                              leading: Icon(Icons.linear_scale_sharp),
                              onTap: () {
                                 Navigator.push(context, 
                                 MaterialPageRoute(builder: (context) => FeedbackClassScreen(feedbackClassId:data[index]['Id'].toString())),);
                              },
                              title: Text(data[index]['name'].toString()),
                              subtitle:StreamBuilder(
                          stream: firestore
                              .collection('Users')
                              .doc(data[index]['Faculty'])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new CircularProgressIndicator();
                            }
                            var document = snapshot.data;
                            return Text('Created by'+' '+document['PersonalInfo']['First Name'] +' '+  document['PersonalInfo']['Last Name']);
                            // return new Text(document["name"]);
                          },
                        ),
                                  
                            );
                          },
                        );
                      }
                      return Text('Its Error!');
                    }),
                )
            
            ],
          ),
        )),
      ),
    );
  }
}
