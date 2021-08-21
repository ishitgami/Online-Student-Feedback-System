import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:osfs1/auth/registrationScreen.dart';
import 'package:osfs1/components/borderTextField.dart';
import 'package:osfs1/admin/index.dart';
import 'package:osfs1/constant.dart';
import 'package:osfs1/components/logoHeading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/student/index.dart';
import 'package:osfs1/faculty/index.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login screen';
   
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dropdownValue = 'Student';
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String email;
  String userpassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,

                stops: [0.1, 0.5],
                colors: [
                  Color(0xFF6a11cb),
                  Color(0xFF2575fc),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: HeadingLogo(color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'LogIn',
                            style: loginHeadingTextStyle,
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 10),
                          BorderTextField(
                            text: 'Enter your Email',
                            icon: Icon(
                              Icons.email,
                              size: 30,
                            ),
                            onChanged: (text) {
                              email = text;
                            },
                          ),
                          SizedBox(height: 10),
                          BorderTextField(
                            text: 'Enter your Password',
                            icon: Icon(
                              Icons.lock,
                              size: 30,
                            ),
                            onChanged: (text) {
                              userpassword = text;
                            },
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(left: 80,right: 80),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(7),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        // side: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async{
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(child: CircularProgressIndicator(),);
                                    });
                                   await  loginByRole();
                                   Navigator.pop(context);
                                    }, 
                                  child: Text('LogIn',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                            },
                            child: Text(
                              'Not Registrated Yet?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.blueAccent),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginByRole() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: userpassword);
      if (user != null) {
        var cUserId = user.user.uid;
        firestore
            .collection('user')
            .where(FieldPath.documentId, isEqualTo: cUserId)
            .get()
            .then((QuerySnapshot<Object> value) => {
                  value.docs.forEach((DocumentSnapshot docs) {
                    if (docs.exists) {
                      Map<String, dynamic> data = docs.data();
                      if (data['role'] == 'admin') {
                        Navigator.pushNamed(context, AdminScreen.id);
                      } else if (data['role'] == 'student') {
                        Navigator.pushNamed(context, StudentScreen.id);
                      } else if (data['role'] == 'faculty') {
                        Navigator.pushNamed(context, FacultyScreen.id);
                      }
                    }
                  })
                });
      }
    } catch (e) {
      print(e);
    }
  }
}
