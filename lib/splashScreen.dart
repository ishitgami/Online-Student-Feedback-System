import 'package:flutter/material.dart';
import 'package:osfs1/presentation/screen/admin/AdminDashbord.dart';
import 'package:osfs1/presentation/screen/auth/login.dart';
import 'package:osfs1/presentation/screen/faculty/FacultyDashbord.dart';
import 'package:osfs1/presentation/screen/student/studentDashboard.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseFirestore firestore = FirebaseFirestore.instance;

class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  int loginNum = 0;
  var uid;
  @override
  void initState() {
    super.initState();
    checkUserType();
  }

  checkUserType() {
    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (user != null) {
        user = auth.currentUser;
        uid = user.uid;
        firestore
            .collection('Users')
            .where(FieldPath.documentId, isEqualTo: uid)
            .get()
            .then((QuerySnapshot<Object> value) => {
                  value.docs.forEach((DocumentSnapshot docs) {
                    if (docs.exists) {
                      Map<String, dynamic> data = docs.data();
                      if (data['role'] == 'Admin') {
                        if (this.mounted) {
                          setState(() {
                            loginNum = 1;
                          });
                        }
                      } else if (data['role'] == 'student') {
                        if (this.mounted) {
                          setState(() {
                            loginNum = 2;
                          });
                        }
                      } else if (data['role'] == 'faculty') {
                        if (this.mounted) {
                          setState(() {
                            loginNum = 3;
                          });
                        }
                      } else {
                        if (this.mounted) {
                          setState(() {
                            loginNum = 0;
                          });
                        }
                      }
                    }
                  })
                });
      } else {
        // print("user is not logged in");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: loginNum == 1
          ? AdminScreen()
          : loginNum == 2
              ? StudentScreen()
              : loginNum == 3
                  ? FacultyDashbordScreen()
                  : LoginScreen(),
      image: Image.asset('img/splashLogo.png'),
      loadingText: Text("Loading"),
      photoSize: 150.0,
      loaderColor: Colors.blue,
    );
  }
}
