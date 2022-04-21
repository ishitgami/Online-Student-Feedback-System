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
    print(uId);
    await firestore.collection('Users').doc(uId).set({
      'role': 'Admin',
      'CreatedAt': Timestamp.now(),
      'UId': uId,
      'InstituteName': institudeName,
      'orgCode': orgCode
    });
  }

  //Add Faculty Data To Firebase After Registration
  void addFacultyData({
    String uId,
    String email,
    String firstName,
    String lastName,

  }) async {
    await firestore.collection('Users').doc(uId).set({
      'role': 'faculty',
      'CreatedAt': Timestamp.now(),
      'UId': uId,
      'Email': email,
      'Name': firstName + ' ' + lastName,
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
      String division}) async {
    await firestore.collection('Users').doc(uId).set({
      'role': 'student',
      'CreatedAt': Timestamp.now(),
        'AcademicYear': academicYear,
        'Department': department,
        'orgCode': division,
        'Email': email,
        'Name': firstName+' '+ lastName,
        'Enrollment No': enrollment,
        'UId': uId,
      
      'FeedbackClass': []
    });
  }
}
