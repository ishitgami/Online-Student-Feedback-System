import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:osfs1/data/data_provider/AdminFirebaseQuery.dart';
import 'AdminModel.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class AdminProvider extends ChangeNotifier {
  // addAcYead(userUid, element) {
  //   AdminFirebaseQuery().addAcYear(userUid, element);
  //   // firestore.collection('Users').doc(userUid).update({
  //   //   'AcYear': FieldValue.arrayUnion([element]),
  //   // });
  //   notifyListeners();
  // }

 

  // addDepartmentData(userUid, element) {
  //   firestore.collection('Users').doc(userUid).update({
  //     'Department': FieldValue.arrayUnion([element]),
  //   });
  //   notifyListeners();
  // }

  // deleteDepartment(userUid, element) {
  //   firestore.collection('Users').doc(userUid).update({
  //     'Department': FieldValue.arrayRemove([element]),
  //   });
  // }

  // addSubject( department, subjectCode, subjectName, semester) {
  //   firestore.collection('Subject').add({
  //     'Code' : '$subjectCode',
  //     'Name' : '$subjectName',
  //     'Department' : '$department',
  //     'Semester' : '$semester'
  //    });
  //   // firestore.collection('Subject').doc(userUid).update({
  //   //   'Subject.$department.$semester':
  //   //       FieldValue.arrayUnion(['$subjectName $subjectCode']),
  //   // });
  // }

  //fetch AdminData For Admin-Module
  Future fetchAdminData() async {
    var userUid = _auth.currentUser.uid;
    var adminQuryResult = await AdminFirebaseQuery().getDocumentById(userUid);
    return AdminData.fromMap(adminQuryResult.data());
  }

  Future fetchAdminData11() async {
    var userUid = _auth.currentUser.uid;
    var adminQuryResult = await AdminFirebaseQuery().getDocumentById(userUid);
    print(adminQuryResult.toString());
    return AdminData.fromMap(adminQuryResult.data());
  }

  //fetch AdminData For Faculty-Module
  Future<AdminData> fetchAdminDatForFaculty() async {
    var userUid = _auth.currentUser.uid;
    var orgCode = await AdminFirebaseQuery().getOrgCode(userUid);
    var result = await AdminFirebaseQuery().getDocumentByorg(orgCode);
    var adminUid = result.docs.first.id;
    var adminQuryResult = await AdminFirebaseQuery().getDocumentById(adminUid);
    notifyListeners();
    return AdminData.fromMap(adminQuryResult.data());
  }

  
  Future fetchAdminDataForStuReg() async {
    var result = await AdminFirebaseQuery().getDataForStudentReg();
    // print('result--->$result');
    return result;
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


// 31 march after  .....

  //Fetch Academic Year Data
  getAcademicYear() {
    var acdemicYearQuery = AdminFirebaseQuery().getAcdemicYear();
    return acdemicYearQuery;
  }

  //Add Academic Year
  addAcademicYear(element) {
    AdminFirebaseQuery().addAcademicYear(element);
    notifyListeners();
  }

  //Delete Academic Year
  deleteAcYear(element) {
    firestore.collection('AcYear').doc(element).delete();
  }

  //Fetch Department Data
  getDepartment() {
    var acdemicYearQuery = AdminFirebaseQuery().getDepartment();
    return acdemicYearQuery;
  }

  //Add Department Year
  addDepartment(element) {
    AdminFirebaseQuery().addDepartment(element);
    notifyListeners();
  }

   //Delete Department Year
  deleteDepartment(element) {
    firestore.collection('Department').doc(element).delete();
  }




  //add Subject
  addSubject( department, subjectCode, subjectName, semester) {
    firestore.collection('Subject').add({
      'Code' : '$subjectCode',
      'Name' : '$subjectName',
      'Department' : '$department',
      'Semester' : '$semester'
     });
  }

  // get subject
  Future<List> getSubject() async {
    var fetchSubjectQuery ;
   fetchSubjectQuery = await  AdminFirebaseQuery().fetchSubject();
   return fetchSubjectQuery;
  }

  //Delete Subject
  deleteSubject(element) {
    firestore.collection('Subject').doc(element).delete();
  }


  
  // get Faculty
  Future<List> getFaculty() async {
    var fetchFacultyQuery ;
   fetchFacultyQuery = await  AdminFirebaseQuery().fetchFaculty();
   return fetchFacultyQuery;
  }


}
