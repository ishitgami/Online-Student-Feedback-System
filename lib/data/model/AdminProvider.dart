import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:osfs1/data/data_provider/AdminFirebaseQuery.dart';
import 'AdminModel.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class AdminProvider extends ChangeNotifier {
  addAcYead(userUid, element) {
    AdminFirebaseQuery().addAcYear(userUid, element);
    // firestore.collection('Users').doc(userUid).update({
    //   'AcYear': FieldValue.arrayUnion([element]),
    // });
    notifyListeners();
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
    notifyListeners();
  }

  deleteDepartment(userUid, element) {
    firestore.collection('Users').doc(userUid).update({
      'Department': FieldValue.arrayRemove([element]),
    });
  }

  addSubject(userUid, department, subjectCode, subjectName, semester) {
    firestore.collection('Users').doc(userUid).update({
      'Subject.$department.$semester':
          FieldValue.arrayUnion(['$subjectName $subjectCode']),
    });
  }

  //fetch AdminData For Admin-Module
  Future<AdminData> fetchAdminData() async {
    // var userUid = _auth.currentUser.uid;
    var adminQuryResult = await AdminFirebaseQuery().getDocumentById();

    return AdminData.fromMap(adminQuryResult);
  }

  Future fetchAdminData11() async {
    // var userUid = _auth.currentUser.uid;
    var adminQuryResult = await AdminFirebaseQuery().getDocumentById();
    print(adminQuryResult.toString());
    return adminQuryResult;
  }

  //fetch AdminData For Faculty-Module
  Future<AdminData> fetchAdminDatForFaculty() async {
    // var userUid = _auth.currentUser.uid;
    // var orgCode = await AdminFirebaseQuery().getOrgCode(userUid);
    // var result = await AdminFirebaseQuery().getDocumentByorg(orgCode);
    // var adminUid = result.docs.first.id;
    var adminQuryResult = await AdminFirebaseQuery().getDocumentById();
    notifyListeners();
    return AdminData.fromMap(adminQuryResult.data());
  }

  getStudentTotal(orgCode) async {
    var studentTotal;
    await firestore
        .collection('Users')
        .where('role', isEqualTo: 'student')
        .where('CollegeData.orgCode', isEqualTo: orgCode)
        .get()
        .then((value) {
      studentTotal = value.size;
    });
    notifyListeners();
    return studentTotal;
  }

  getFacultyTotal(orgCode) async {
    var facultyTotal;
    await firestore
        .collection('Users')
        .where('role', isEqualTo: 'faculty')
        .where('orgCode', isEqualTo: orgCode)
        .get()
        .then((value) {
      facultyTotal = value.size;
    });
    notifyListeners();
    return facultyTotal;
  }
}
