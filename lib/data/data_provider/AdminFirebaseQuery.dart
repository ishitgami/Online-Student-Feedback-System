import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

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
    var acdemicYearMapList = <Map>[];
    await _db.collection('AcYear').get().then((value) {
      value.docs.forEach((element) {
        acdemicYearMapList
            .add({
              'id': '${element.id}',
              'Year': '${element['Year']}',
              });
      });
    });
    return acdemicYearMapList;
  }

  //add Academic Year
  addAcademicYear(element) {
    _db.collection('AcYear').add({
      'Year': "$element",
    });
  }

  //fetch Department Date
  getDepartment() async {
    var departmentMapList = <Map>[];
    await _db.collection('Department').get().then((value) {
      value.docs.forEach((element) {
        departmentMapList
            .add({
              'id': '${element.id}',
              'Department': '${element['Department']}',
              });
      });
    });
    return departmentMapList;
  }

  // add department
  addDepartment(element) {
    _db.collection('Department').add({
      'Department': "$element",
    });
  }

  addSubject(element) {
    _db.collection('AcYear').add({
      'Year': "$element",
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
          'Name': '${element.data()['Name']}',
          'Email': '${element.data()['Email']}',
        });
      });
    });
    return facultyMapList;
  }

  //add Question
  addQuestion(element) {
    _db.collection('Questions').add({
      'Question': "$element",
    });
  }

    // Fetch Feedback Question
  fetchFeedQuestion() async {
    var feedQuesMapList = <Map>[];
    await _db.collection('Questions').get().then((value) {
      value.docs.forEach((element) {
        feedQuesMapList.add({
          'id': '${element.id}',
          'Que': '${element['Question']}',
        });
      });
    });
    return feedQuesMapList;
  }

  //getAcademicYearList
  getAcdemicYearList() async {
    var acdemicYearList = [];
    await _db.collection('AcYear').get().then((value) {
      value.docs.forEach((element) {
        acdemicYearList
            .add(element['Year']);
      });
    });
    return acdemicYearList;
  }


  // Fetch feedbackClass
  fetchFeedbackClass() async {
    var feedbackClassMapList = <Map>[];
    await _db.collection('FeedbackClass').get().then((value) {
      value.docs.forEach((element) {
        feedbackClassMapList.add({
          'id': '${element.id}',
          'Faculty': '${element['Faculty']}',
          'AcademicYear': '${element['AcademicYear']}',
          'Department': '${element['Department']}',
          'Name': '${element['Name']}',
          'subject': '${element['subject']}',
        });
      });
    });
    return feedbackClassMapList;
  }


  // Fetch feedbackClass For Student
  fetchFeedbackClassForStudent(studentId) async {
    var feedbackClassMapList = <Map>[];
    await _db.collection('FeedbackClass').where('StudentList.$studentId',isEqualTo: false).get().then((value) {
      value.docs.forEach((element) {
        feedbackClassMapList.add({
          'id': '${element.id}',
          'Faculty': '${element['Faculty']}',
          'AcademicYear': '${element['AcademicYear']}',
          'Department': '${element['Department']}',
          'Name': '${element['Name']}',
          'subject': '${element['subject']}',
        });
      });
    });
    return feedbackClassMapList;
  }

    // Fetch feedbackClass Question
  fetchFeedbackClassQuestions(feedbaclClassId) async {
    var feedbackClassMapList = <Map>[];
    await _db.collection('FeedbackClass').doc(feedbaclClassId).collection('Questions').get().then((value) {
      value.docs.forEach((element) {
        feedbackClassMapList.add({
          'id': '${element.id}',
          'Qid': '${element['id']}',
          'question': '${element['question']}',
        });
      });
    });
    return feedbackClassMapList;
  }

 



}
