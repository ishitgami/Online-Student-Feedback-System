import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AdminModel.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
var acYearList;

class CollegeData extends ChangeNotifier {
  List<AdminData> adminData;

  AdminData adminDatta;

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

  addAcData(userUid, element) {
    firestore.collection('Users').doc(userUid).update({
      'AcYear': FieldValue.arrayUnion([element]),
    });
    ChangeNotifier();
  }

  getAcData(userUid) async {
    acYearList = [];
    await firestore.collection('Users').doc(userUid).get().then((value) => {
          acYearList = value['AcYear'],
        });
    ChangeNotifier();
    return acYearList;
  }

  deleteAcYear(userUid, element) {
    firestore.collection('Users').doc(userUid).update({
      'AcYear': FieldValue.arrayRemove([element]),
    });
  }

  addDepartmentData(userUid, element) {
    firestore.collection('Users').doc(userUid).update({
      'Department': FieldValue.arrayUnion([element]),
    });
    ChangeNotifier();
  }

  getDepartmentData(userUid) async {
    acYearList = [];
    await firestore.collection('Users').doc(userUid).get().then((value) => {
          acYearList = value['Department'],
        });
    ChangeNotifier();
    return acYearList;
  }

  deleteDepartment(userUid, element) {
    firestore.collection('Users').doc(userUid).update({
      'Department': FieldValue.arrayRemove([element]),
    });
  }

  addSubject(userUid, department, subjectCode, subjectName, semester) {
    firestore.collection('Users').doc(userUid).update({
      'Subject.$department.$semester': FieldValue.arrayUnion(['$subjectName $subjectCode']),
    });
  }

  Future<List<AdminData>> fetchAdminData() async {
    var userUid = _auth.currentUser.uid;
    var result = await firestore.collection('Users').where('UId',isEqualTo: userUid).get();
    adminData = result.docs
        .map((doc) => AdminData.fromMap(doc.data())).toList();
    return adminData;

  }

  getOrgCode(userUid) async {
    var orgCode;
    await firestore.collection('Users').doc(userUid).get().then((value) => {
          orgCode = value['orgCode'],
        });
        return orgCode;
  }

   Future<List<AdminData>> fetchAdminDatForFaculty() async {
    var userUid = _auth.currentUser.uid;
    var orgCode = await getOrgCode(userUid);
    var result = await firestore.collection('Users').where('role',isEqualTo: 'Admin').where('orgCode',isEqualTo: orgCode).get();
    adminData = result.docs
        .map((doc) => AdminData.fromMap(doc.data())).toList();
    return adminData;
  }
}


