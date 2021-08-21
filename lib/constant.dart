import 'package:flutter/material.dart';

const loginHeadingTextStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w900,
    letterSpacing: 1,
    color: Colors.blueAccent);

  List<dynamic> facultyList;
  List<dynamic> departmentList;
  List<dynamic> academicYearList;
  List<dynamic> divisionList;
  List<dynamic> subjectList;
  List<dynamic> studentList;
  List<dynamic> feedbackList;
  List<dynamic> feedbackQueList;

  Map facultyMap;
  Map academicYearMap;
  Map departmentMap;
  Map divisionMap;
  Map subjectMap;
  Map feedbackQueMap;
  var studentMap = <Map>[];
  var feedbackQueByDivisionMap = <Map>[];

  var currentFacultyValue;
  var currentFacultyId;
  var currentAcademicYearValue;
  var currentDepartmentValue;
  var currentDivisionValue;
  var currentAcademicYearId;
  var currentDepartmentId;
  var currentDivisionId;
  var currentSubjectId;
  var currentSubjectValue;
  var currentStudentId;
  var currentFeedbackValue;
  var valueData;
  var studentData;