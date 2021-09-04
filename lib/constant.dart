import 'package:flutter/material.dart';


const loginHeadingTextStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w900,
    letterSpacing: 1,
    color: Colors.blueAccent
);

  List<dynamic> facultyList;
  List<dynamic> departmentList;
  List<dynamic> academicYearList;
  List<dynamic> divisionList;
  List<dynamic> subjectList;
  List<dynamic> studentList;
  List<dynamic> feedbackList;
  

  Map facultyMap;
  Map academicYearMap;
  Map departmentMap;
  Map divisionMap;
  Map subjectMap;
  Map feedbackQueMap;
  var studentMap = <Map>[];
  var feedbackQueMapList = <Map>[];

  var currentAcademicYearId;
  var currentDepartmentId;
  var currentDivisionId;
  var currentFacultyId;
  var currentStudentId;
  var currentSubjectId;

  var currentFacultyValue;
  var currentAcademicYearValue;
  var currentDepartmentValue;
  var currentDivisionValue;
  var currentSubjectValue;
  var currentFeedbackValue;
  
  var valueData;

  var studentData;
  var sEmail;
  var sPassword;
  var sFirstName;
  var sLastName;

  //AcademicYear.dart
  var academicYear1;
  var academicYear2;
  
  //Division.dart
   var addDivision;

  //Department.dart
  var addDepartment;

  //Student index.dart
  List<dynamic> subjectFeedbackId;
  var uid;

  //login.dart
  String email;

  //feedbackque.dart
  List<dynamic> feedbackQueList;
