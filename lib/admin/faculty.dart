import 'package:flutter/material.dart';
import 'DrawerAdmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FacultyInAdmin extends StatefulWidget {


  @override
  _FacultyInAdminState createState() => _FacultyInAdminState();
}

class _FacultyInAdminState extends State<FacultyInAdmin> {

  @override
  Widget build(BuildContext context) {
    
    var sEmail;
    var sPassword;
    var sFirstName;
    var sLastName;

     final _auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty'),
      ),
    drawer: AdminDrawer(),
      body: SafeArea(
        child:Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                        onChanged: (text) {
                          sFirstName = text;
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                        onChanged: (text) {
                          sLastName = text;
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        onChanged: (text) {
                          sEmail = text;
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        onChanged: (text) {
                          sPassword = text;
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () async {
                            print(sEmail);
                            print(sPassword);
                            // Navigator.pushNamed(context, LoginScreen.id);
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: sEmail, password: sPassword);
                              print(newUser.user.email);
                              if (newUser != null) {
                                var cUserId = newUser.user.uid;
                                print(cUserId);
                                firestore
                                    .collection('user')
                                    .doc(cUserId)
                                    .set({
                                  'Email' : '$sEmail',
                                  'role': 'faculty'
                                });
                                firestore
                                    .collection('faculty')
                                    .doc(cUserId)
                                    .set({
                                  'First Name': '$sFirstName',
                                  'Last Name': '$sLastName',
                                  'Email' : '$sEmail',
                                  'role': 'faculty'
                                });
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text('SUBMIT')),
                    ],
                  ),
                ),
              ),
            ),
        ),

    );
  }
}