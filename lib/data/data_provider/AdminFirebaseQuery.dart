import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AdminFirebaseQuery {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  //get Current User UId
  Future<String> getCurrentUserUid() async {
    var user = _auth.currentUser;
    return user.uid;
  }

  //get User-Data By ID
  Future getDocumentById(uid) {
    var data = _db.collection('Users').doc(uid).get();
    return data;
  }

  // get admin Data for student reg
  Future getDataForStudentReg() async {
    List data = [];
    await _db.collection('AcYear').get().then((value) {
      value.docs.forEach((DocumentSnapshot docs) {
        if (docs.exists) {
          data.add(docs['Year']);
        }
      });
    });
    return data;
  }

  //get User-Data by OrgCode
  Future<QuerySnapshot> getDocumentByorg(String orgCode) {
    return _db
        .collection('Users')
        .where('role', isEqualTo: 'Admin')
        .where('orgCode', isEqualTo: orgCode)
        .get();
  }

  //Get OrgCode By Id
  Future<String> getOrgCode(userUid) async {
    String orgCode;
    await _db.collection('Users').doc(userUid).get().then((value) => {
          orgCode = value['orgCode'],
        });
    return orgCode;
  }

  //Add Academic Year
  addAcYear(userUid, element) {
    _db.collection('Users').doc(userUid).update({
      'AcYear': FieldValue.arrayUnion([element]),
    });
  }

  //get Faculty-Total By OrgCode
  getFacultyTotal(orgCode) async {
    var facultyTotal;
    await _db
        .collection('Users')
        .where('role', isEqualTo: 'faculty')
        .where('orgCode', isEqualTo: orgCode)
        .get()
        .then((value) {
      facultyTotal = value.size;
    });
    return facultyTotal;
  }

// new 31 march after

  //getAcademicYear
  getAcdemicYear() async {
    var acdemicYearMap = {};
    await _db.collection('AcYear').get().then((value) {
      value.docs.forEach((element) {
        acdemicYearMap
            .addAll({'${element.id}': '${(element.data().values.first)}'});
      });
    });
    return acdemicYearMap;
  }

  //add Academic Year
  addAcademicYear(element) {
    _db.collection('AcYear').add({
      'Year': "$element",
    });
  }

  //fetch Department Date
  getDepartment() async {
    var departmentMap = {};
    await _db.collection('Department').get().then((value) {
      value.docs.forEach((element) {
        departmentMap
            .addAll({'${element.id}': '${(element.data().values.first)}'});
      });
    });
    return departmentMap;
  }

  // add department
  addDepartment(element) {
    _db.collection('Department').add({
      'Department': "$element",
    });
  }

  // FetchSubject
  fetchSubject() async {
    var subjectMapList = <Map>[];
    await _db.collection('Subject').get().then((value) {
      value.docs.forEach((element) {
        subjectMapList.add({
          'id': '${element.id}',
          'Code': '${element['Code']}',
          'Department': '${element['Department']}',
          'Name': '${element['Name']}',
          'Semester': '${element['Semester']}',
        });
      });
    });
    return subjectMapList;
  }

    // Fetch Faculty
  fetchFaculty() async {
    var facultyMapList = <Map>[];
    await _db.collection('Users').where('role',isEqualTo: 'faculty').get().then((value) {
      value.docs.forEach((element) {
        facultyMapList.add({
          'id': '${element.data()['UId']}',
          'Name': '${element.data()['PersonalInfo']['First Name']}' + ' ' + '${element.data()['PersonalInfo']['Last Name']}',
          'Email': '${element.data()['PersonalInfo']['Email']}',
        });
      });
    });
    return facultyMapList;
  }
}
