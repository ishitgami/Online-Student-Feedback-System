import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/presentation/router/route.dart';
import 'package:osfs1/presentation/screen/student/feedbackScreen.dart';
import 'package:provider/provider.dart';
import 'feedbackClassScreen.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
   final auth = FirebaseAuth.instance;
  User user;
  AdminProvider collegedata;

  var feedbackClassMapList;


  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    uid = user.uid;
  }

  @override
  Widget build(BuildContext context) {

    collegedata = Provider.of<AdminProvider>(context);

    collegedata.getFeedbackClassForStudent(uid).then((value) {
      setState(() {
         feedbackClassMapList = value;
      });
        

    });
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
              FirebaseFirestore.instance.clearPersistence();
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, loginScreenRoute);
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
            child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: feedbackClassMapList == null ? 0 : feedbackClassMapList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => FeedbackScreen(feedbackClassMapList.elementAt(index)['id'].toString())));
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feedbackClassMapList.elementAt(index)['Name'].toString(),
                                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                feedbackClassMapList.elementAt(index)['subject'].toString(),
                                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                              ),
                               Text(
                                feedbackClassMapList.elementAt(index)['AcademicYear'].toString(),
                               
                              ),
                              Text(
                                feedbackClassMapList.elementAt(index)['Department'].toString(),
                                
                                style: TextStyle(fontSize: 14.0,),
                              ),
                            ],
                          ),
                        
                          
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      
      ),
      ),
      ),
    );
  }
}
