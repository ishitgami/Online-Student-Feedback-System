import 'package:flutter/material.dart';

const loginHeadingTextStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w900,
    letterSpacing: 1,
    color: Colors.blueAccent);

//Admin Dashbord Style
const orgDataTextStyle =
    TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold);

const orgHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w400
);

const containerHeadingStyle =
    TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold);

const containerDecoration = BoxDecoration(
    color: Colors.white, 
    borderRadius: const BorderRadius.all(Radius.circular(5))
    );

String instituteName;
String email;
String password;
String firstName;
String lastName;
String orgId;
var emailAddress;
var enrollmentNo;

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

var userData;
var studentData;

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

//feedbackque.dart
List<dynamic> feedbackQueList;
