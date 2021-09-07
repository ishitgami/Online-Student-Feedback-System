import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osfs1/components/simpleDropdown.dart';
import 'package:osfs1/getData/getAcademicYear.dart';
import 'package:osfs1/getData/getDepartment.dart';
import 'package:osfs1/getData/getDivision.dart';
import 'package:osfs1/getData/getStudents.dart';
import 'DrawerAdmin.dart';
import 'package:osfs1/constant.dart';

class StudentInAdminScreen extends StatefulWidget {
  @override
  _StudentInAdminScreenState createState() => _StudentInAdminScreenState();
}

class _StudentInAdminScreenState extends State<StudentInAdminScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    academicYearData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('student'),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                    });
                  }),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: studentData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: studentMap.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          studentMap[index]['Enrolment']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          studentMap[index]['FirstName']
                                                  .toString() +
                                              ' ' +
                                              studentMap[index]['MiddleName']
                                                  .toString() +
                                              ' ' +
                                              studentMap[index]['LastName']
                                                  .toString(),
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        Text(
                                          studentMap[index]['Email'].toString(),
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ],
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
                                                  deleteStudent(index);
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
                          );
                        },
                      );
                    }
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

  Future studentData() async {
    studentList = [];
    await GetStudentData(
            currentAcademicYearId: currentAcademicYearId,
            currentDepartmentId: currentDepartmentId,
            currentDivisionId: currentDivisionId)
        .getStudentdata()
        .then((value) => {
              studentMap = value,
            });
    return studentMap;
  }

  deleteStudent(index) {
    firestore
        .collection('Academic Year')
        .doc(currentAcademicYearId)
        .collection('Department')
        .doc(currentDepartmentId)
        .collection('Division')
        .doc(currentDivisionId)
        .collection('Students')
        .doc(studentMap[index]['id'])
        .delete()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
    firestore
        .collection('user')
        .doc(studentMap[index]['id'])
        .delete()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
  }

}
