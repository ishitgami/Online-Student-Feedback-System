import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:osfs1/data/model/Authentication.dart';
import 'package:osfs1/components/borderTextField.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'package:osfs1/components/logoHeading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/presentation/router/route.dart';
import 'package:provider/provider.dart';
import 'package:double_back_to_close/double_back_to_close.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Authentication userProvider;
  bool showLoading = false;
  bool showAlert = false;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<Authentication>(context);
    return DoubleBack(
      onFirstBackPress: (context) {
        final snackBar = SnackBar(content: Text('Press back again to exit'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Scaffold(
        body: SafeArea(
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
                  child: HeadingLogo(
                    color: Colors.white,
                  ),
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
                              password = text;
                            },
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(left: 80, right: 80),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(7),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                      setState(() {
                                    showLoading = true;
                                      });
                                    progressIndicater(context,showLoading = true);
                                    await loginByRole();
                                    showAlert == true ? null : progressIndicater(context,showLoading = true);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'LogIn',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, navToDiffRegistrationRoute);
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

  Future<dynamic> progressIndicater(BuildContext context ,showLoading) {
    
    if(showLoading == true) {
     return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }) ;
    } else return null;

  }

  loginByRole() async {
    try {
      final user = await userProvider.loginAuthentication(
          email: email, password: password);
      firestore
          .collection('Users')
          .where(FieldPath.documentId, isEqualTo: user.toString())
          .get()
          .then((QuerySnapshot<Object> value) => {
                value.docs.forEach((DocumentSnapshot docs) {
                  if (docs.exists) {
                    Map<String, dynamic> data = docs.data();
                    if (data['role'] == 'Admin') {
                      Navigator.pushNamed(context, AdminScreenRoute);
                    } else if (data['role'] == 'student') {
                      Navigator.pushNamed(context, studentScreenRoute);
                    } else if (data['role'] == 'faculty') {
                      Navigator.pushNamed(context, FacultyDashbordScreenRoute);
                    }
                  }
                })
              });
      // }
    } catch (e) {
      return alertBox(context, e);
    }
  }

  Future<void> alertBox(BuildContext context, e) {
    setState(() {
                                    showLoading = false;
                                    showAlert = true;
                                      });
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        elevation: 5,
        title: Text("Alert !!"),
        content: Text(e.toString()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              "Close",
              style: TextStyle(
                  color: Colors.red, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
