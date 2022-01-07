import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class AddUserDataFirebase extends ChangeNotifier { 
  
  //Add Organization Data To Firebase After Registration
  void addOrgnationData({
    String uId,
    String institudeName,
    String orgCode,
  }) async {
    await firestore.collection('Users').doc(uId).set({
      'role': 'Admin',
      'CreatedAt': Timestamp.now(),
      'UId': uId,
      'InstituteName': institudeName,
      'orgCode': orgCode
    });
  }

    // Add StudentData To Firebase After Registration
  void addStudentData(
      {String uId,
      String academicYear,
      String department,
      String email,
      String firstName,
      String lastName,
      String enrollment,
      String orgCode}) async {
    await firestore.collection('Users').doc(uId).set({
      'role': 'student',
      'orgCode': orgCode,
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



}
