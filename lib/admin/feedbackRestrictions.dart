import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osfs1/components/simpleDropdown.dart';
import 'package:osfs1/getData/getAcademicYear.dart';
import 'package:osfs1/getData/getDepartment.dart';
import 'package:osfs1/getData/getDepartmentOfSubject.dart';
import 'package:osfs1/getData/getDivision.dart';
import 'package:osfs1/getData/getFaculty.dart';
import 'package:osfs1/getData/getFeedback.dart';
import 'package:osfs1/getData/getFeedbackQue.dart';
import 'package:osfs1/getData/getStudents.dart';
import 'DrawerAdmin.dart';
import 'package:osfs1/constant.dart';

class RestrictionsScreen extends StatefulWidget {
  @override
  _RestrictionsScreenState createState() =>
      _RestrictionsScreenState();
}

class _RestrictionsScreenState
    extends State<RestrictionsScreen> {
  Map studentIdMap = Map();
  var feedbackMap = [];
    var feedbackMap2 = [];
    List<dynamic> feedbackList = [].toList();
    List<dynamic> feedbackList2 = [].toList();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future facultyData() async {
    facultyList = [];
    try {
      await GetFacultyData().getfaculty().then((value) => {
            facultyMap = value,
            value.forEach((key, value) {
              setState(() {
                facultyList.add(value);
              });
            })
          });
    } catch (e) {
      print(e);
    }
    return facultyList;
  }

  Future<void> studentData() async {
    studentIdMap = Map();
    await GetStudentData(
            currentAcademicYearId: currentAcademicYearId,
            currentDepartmentId: currentDepartmentId,
            currentDivisionId: currentDivisionId)
        .getStudentdata()
        .then((value) => {
              value.forEach((element) {
                studentIdMap.addAll({element['id']: false});
              
              }),
            });
              print('studentIdMap---->$studentIdMap');
  }

  Future<void> feedbackQue() async {
    await FeedbackQueData().getFeedbackQue().then((value) => {
      setState(() {
          feedbackQueMap = value;
          })
        });
  }

  Future dipartmentOfSubjectData() async {
    subjectList = [];
    try {
      await GetDepartmentOfSubject().getDepartment().then((value) => {
            subjectMap = value,
            value.forEach((key, value) {
              setState(() {
                subjectList.add(value);
              });
            })
          });
    } catch (e) {
      print(e);
    }
    return subjectList;
  }

  Future academicYearData() async {
    academicYearList = [];
    await GetAcademicYearData().getAcademicYear().then((value) => {
          academicYearMap = value,
          value.forEach((key, value) {
            setState(() {
              academicYearList.add(value);
            });
          })
        });
    return academicYearList;
  }

  Future deparmentData() async {
    departmentList = [];
    await GetDepartmentData(currentAcademicYearId: currentAcademicYearId)
        .getDepartment()
        .then((value) => {
              departmentMap = value,
              value.forEach((key, value) {
                setState(() {
                  departmentList.add(value);
                });
              })
            });
    return departmentMap;
  }

  Future divisionData() async {
    divisionList = [];
    await GetDivisionData(
            currentAcademicYearId: currentAcademicYearId,
            currentDepartmentId: currentDepartmentId)
        .getDivisiondata()
        .then((value) => {
              divisionMap = value,
              value.forEach((key, value) {
                setState(() {
                  divisionList.add(value);
                });
              })
            });
    return divisionMap;
  }

  Future feedbackData() async {
    feedbackList = [];
    await FeedbackData().getFeedback().then((value) => {
            
            feedbackList = value,
          
        });
    return feedbackList;
  }

  void addQuesToStudent(element, queNo) {
    firestore
        .collection('Academic Year')
        .doc(currentAcademicYearId)
        .collection('Department')
        .doc(currentDepartmentId)
        .collection('Division')
        .doc(currentDivisionId)
        .collection('feedback')
        .doc(currentAcademicYearValue +
            '_' +
            currentDepartmentValue +
            '_' +
            currentDivisionValue +
            '_' +
            currentSubjectValue +
            '_' +
            currentFacultyValue)
        .collection('questions')
        .doc(queNo.toString())
        .set({
      'que': element,
    });
  }

  void addQuesToFaculty(element, queNo) {
    firestore
        .collection('faculty')
        .doc(currentFacultyId)
        .collection('feedback')
        .doc(currentAcademicYearValue +
            '_' +
            currentDepartmentValue +
            '_' +
            currentDivisionValue +
            '_' +
            currentSubjectValue +
            '_' +
            currentFacultyValue)
        .collection('questions')
        .doc(queNo.toString())
        .set({
      'que': element,
    });
  }

  void addQueToFeedback(element, queNo) {
    firestore
        .collection('feedback')
        .doc(currentAcademicYearValue +
            '_' +
            currentDepartmentValue +
            '_' +
            currentDivisionValue +
            '_' +
            currentSubjectValue +
            '_' +
            currentFacultyValue)
        .collection('questions')
        .doc(queNo.toString())
        .set({
      'que': element,
    });
    queNo++;
  }

  @override
  void initState() {
    super.initState();
    facultyData();
    academicYearData();
    dipartmentOfSubjectData();
    feedbackQue();
    feedbackData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Restrictions'),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'FACULTY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: simpleDropdown(
                      currentFacultyValue, facultyList, 'choose Academic Year',
                      (value) {
                    setState(() {
                      currentFacultyId = facultyMap.keys.firstWhere(
                          (element) => facultyMap[element] == value);
                      currentFacultyValue = value;
                    });
                  }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'ACADEMIC YEAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: simpleDropdown(currentAcademicYearValue,
                      academicYearList, 'choose Academic Year', (value) {
                    setState(() {
                      currentAcademicYearId = academicYearMap.keys.firstWhere(
                          (element) => academicYearMap[element] == value);
                      currentAcademicYearValue = value;
                      currentDepartmentValue = null;
                      currentDivisionValue = null;
                      deparmentData();
                    });
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'DEPARTMENT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: simpleDropdown(currentDepartmentValue, departmentList,
                      'choose department', (value) {
                    setState(() {
                      currentDepartmentId = departmentMap.keys.firstWhere(
                          (element) => departmentMap[element] == value);
                      currentDepartmentValue = value;
                      currentDivisionValue = null;
                      divisionData();
                    });
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'DIVISION',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: simpleDropdown(
                      currentDivisionValue, divisionList, 'choose Division',
                      (value) {
                    setState(() {
                      currentDivisionId = divisionMap.keys.firstWhere(
                          (element) => divisionMap[element] == value);
                      currentDivisionValue = value;
                      studentData();
                    });
                  }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'SUBJECT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: simpleDropdown(
                      currentSubjectValue, subjectList, 'choose Department',
                      (value) {
                    setState(() {
                      currentSubjectId = subjectMap.keys.firstWhere(
                          (element) => subjectMap[element] == value);
                      currentSubjectValue = value;
                    });
                  }),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
              
                  try {
                    var a = await firestore
                        .collection('feedback')
                        .doc(currentAcademicYearValue +
                            '_' +
                            currentDepartmentValue +
                            '_' +
                            currentDivisionValue +
                            '_' +
                            currentSubjectValue +
                            '_' +
                            currentFacultyValue)
                        .get();

                    feedbackQueMap.values.forEach((element) {
                      if (a.exists) {
                        print('exists');
                        return null;
                      }
                      if (!a.exists) {
                        print('Not exists');
                        setState(() {
                          
                        
                        firestore
                            .collection('feedback')
                            .doc(currentAcademicYearValue +
                                '_' +
                                currentDepartmentValue +
                                '_' +
                                currentDivisionValue +
                                '_' +
                                currentSubjectValue +
                                '_' +
                                currentFacultyValue)
                            .set({
                          'Faculty': currentFacultyValue,
                          'ID': {
                            'AcademicYearId': currentAcademicYearId,
                            'DepartmentId': currentDepartmentId,
                            'DivisionId': currentDivisionId,
                            'FeedbackId': currentAcademicYearValue +
                                '_' +
                                currentDepartmentValue +
                                '_' +
                                currentDivisionValue +
                                '_' +
                                currentSubjectValue +
                                '_' +
                                currentFacultyValue,
                            'facultyId': currentFacultyId
                          }
                        });

                        

                        firestore
                            .collection('faculty')
                            .doc(currentFacultyId)
                            .collection('feedback')
                            .doc(currentAcademicYearValue +
                                '_' +
                                currentDepartmentValue +
                                '_' +
                                currentDivisionValue +
                                '_' +
                                currentSubjectValue +
                                '_' +
                                currentFacultyValue)
                            .set({
                          'Faculty': currentFacultyValue,
                        });
                        addQueToFeedback(element, element.hashCode);
                        addQuesToFaculty(element, element.hashCode);
                        addQuesToStudent(element, element.hashCode);
                        });
                      }
                      
                    });
                    firestore
                            .collection('Academic Year')
                            .doc(currentAcademicYearId)
                            .collection('Department')
                            .doc(currentDepartmentId)
                            .collection('Division')
                            .doc(currentDivisionId)
                            .collection('feedback')
                            .doc(currentAcademicYearValue +
                                '_' +
                                currentDepartmentValue +
                                '_' +
                                currentDivisionValue +
                                '_' +
                                currentSubjectValue +
                                '_' +
                                currentFacultyValue)
                            .set({
                          'Faculty': currentFacultyValue,
                          'FId': currentFacultyId,
                          'submitted': studentIdMap
                        });
                        SetOptions(merge: true);
                    return null;
                  } catch (e) {
                    print(e);
                  }
                
                },
                child: Text('ADD')),
            Expanded(
              child: FutureBuilder(
                future: feedbackData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: feedbackList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          // onTap: ,
                          child: Card(
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      feedbackList[index]['FeedbackId'].toString(),
                                      style: TextStyle(fontSize: 22.0),
                                    ),
                                  ),
                                  IconButton(
                                    alignment: Alignment.centerLeft,
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          content: Text(
                                              "Are you sure you want to delete ?"),
                                          actions: [
                                            TextButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  firestore
                                                      .collection('feedback')
                                                      .doc(feedbackList[index]['FeedbackId'])
                                                      .delete()
                                                      .then((_) =>
                                                          print('Deleted'))
                                                      .catchError((error) => print(
                                                          'Delete failed: $error'));
                                                      firestore
                                                      .collection('Academic Year')
                                                      .doc(feedbackList[index]['AcademicYearId'])
                                                      .collection('Department')
                                                      .doc(feedbackList[index]['DepartmentId'])
                                                      .collection('Division')
                                                      .doc(feedbackList[index]['DivisionId'])
                                                      .collection('feedback')
                                                      .doc(feedbackList[index]['FeedbackId'])
                                                       .delete()
                                                      .then((_) =>
                                                          print('Deleted'))
                                                      .catchError((error) => print(
                                                          'Delete failed: $error'));
                                                      
                                                      firestore
                                                      .collection('faculty')
                                                      .doc(feedbackList[index]['facultyId'])
                                                      .collection('feedback')
                                                      .doc(feedbackList[index]['FeedbackId'])
                                                       .delete()
                                                      .then((_) =>
                                                          print('Deleted'))
                                                      .catchError((error) => print(
                                                          'Delete failed: $error'));


                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
