import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth/login.dart';
import 'admin/index.dart';
import 'faculty/index.dart';
import 'student/index.dart';

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
    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (user != null) {
        user = auth.currentUser;
        uid = user.uid;
        print("user is logged in");
        print(uid);
        firestore
            .collection('user')
            .where(FieldPath.documentId, isEqualTo: uid)
            .get()
            .then((QuerySnapshot<Object> value) => {
                  value.docs.forEach((DocumentSnapshot docs) {
                    if (docs.exists) {
                      Map<String, dynamic> data = docs.data();
                      if (data['role'] == 'admin') {
                        setState(() {
                          loginNum = 1;
                        });
                      } else if (data['role'] == 'student') {
                        setState(() {
                          loginNum = 2;
                        });
                      } else if (data['role'] == 'faculty') {
                        setState(() {
                          loginNum = 3;
                        });
                      }
                    }
                  })
                });
      } else {
        print("user is not logged in");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: loginNum == 1
          ? AdminScreen
          : loginNum == 2
              ? StudentScreen()
              : loginNum == 3
                  ? FacultyScreen()
                  : LoginScreen(),
      // title: new Text(
      //   'GeeksForGeeks',
      //   textScaleFactor: 2,
      // ),
      image: Image.asset('img/splashLogo.png'),
      loadingText: Text("Loading"),
      photoSize: 150.0,
      loaderColor: Colors.blue,
    );
  }
}
