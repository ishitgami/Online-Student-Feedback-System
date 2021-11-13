import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/auth/authErrorHendling.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;


  loginAuthentication({
    String email,
    String password,
  }) async {
    String userUId;
    String errorMessage;
    var newUser;
    try {
      newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      userUId = newUser.user.uid;
    } catch (error) {
      print(error.code);
      errorMessage = ErrorHangling().throwErrorMesg(errorCode: error.code);
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return userUId.toString();
  }

  registrationAuthentication({
    String emailAddress,
    String password,
  }) async {
    String errorMessage;
    String userUId;
    var newUser;

    try {
      newUser = await _auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      userUId = newUser.user.uid;
    } catch (error) {
      errorMessage = ErrorHangling().throwErrorMesg(errorCode: error.code);
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return userUId.toString();
  }

  void addStudentData({
    String uId,
    String academicYear,
    String department,
    String email,
    String firstName,
    String lastName,
    String enrollment,
  }) async {
    await firestore.collection('Users').doc(uId).set({
      'role': 'student',
      'CreatedAt': Timestamp.now(),
      'CollegeData': {
        'AcademicYear': academicYear,
        'Department': department,
      },
      'PersonalInfo': {
        'Email': email,
        'First Name': firstName,
        'Last Name': lastName,
        'Enrollment No': enrollment,
        'UId': uId,
      },
      'FeedbackClass': []
    });
  }

  void addOrgnationData({
    String uId,
    String institudeName
  }) async{
    await firestore.collection('Users').doc(uId).set({
      'role': 'Admin',
      'CreatedAt': Timestamp.now(),
      'UId' : uId,
      'InstituteName' : institudeName,
    });
  }

}
