import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class AdminModel extends ChangeNotifier { 
   User loggedInUser;

   getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
    return loggedInUser;
  }

   Future getOrgCode(loggedInUser) async{
     String orgCode;
    await firestore
        .collection('Users')
        .doc(loggedInUser)
        .get()
        .then((value) => {
          orgCode = value['orgCode'],
        });
        return orgCode.toString();
  }

  getStudentTotal(orgCode) async {
  var studentTotal;
   await firestore
     .collection('Users')
     .where('role', isEqualTo: 'student')
     .where('CollegeData.orgCode',isEqualTo: orgCode)
     .get().then((value){
      studentTotal =  value.size;
     });
     return studentTotal;
  }

  getFacultyTotal(orgCode) async {
  var facultyTotal;
   await firestore
     .collection('Users')
     .where('role', isEqualTo: 'faculty')
     .where('orgCode',isEqualTo: orgCode)
     .get().then((value){
      facultyTotal =  value.size;
     });
     return facultyTotal;
  }
  

}
