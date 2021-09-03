import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:osfs1/components/simpleDropdown.dart';
import 'package:osfs1/getData/getAcademicYear.dart';
import 'package:osfs1/getData/getDepartment.dart';
import 'package:osfs1/getData/getDivision.dart';
import 'package:wave/config.dart';

import 'package:wave/wave.dart';

import '../route.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _form = GlobalKey<FormState>(); //for storing form state.

  var sEmail;
  var sPassword;
  var sFirstName;
  var sLastName;
  var sEnrollment;
  var sMiddleName;

  List<dynamic> departmentList;
  List<dynamic> academicYearList;
  List<dynamic> divisionList;

  Map academicYearMap;
  Map departmentMap;
  Map divisionMap;

  var currentAcademicYearValue;
  var currentDepartmentValue;
  var currentAcademicYearId;
  var currentDepartmentId;
  var currentDivisionId;
  var currentDivisionValue;

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
    return departmentList;
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
    return divisionList;
  }

  //saving form after validation
  void _saveForm() {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
  }

  void addStudentToUser(cUserId) {
    firestore.collection('user').doc(cUserId).set({
      'role': 'student',
      'Email': '$sEmail',
      'academicId': currentAcademicYearId,
      'departmentId': currentDepartmentId,
      'divisionId': currentDivisionId,
      'userId': cUserId
    });
  }

  void addStudentToDivision(cUserId) {
    firestore
        .collection('Academic Year')
        .doc(currentAcademicYearId)
        .collection('Department')
        .doc(currentDepartmentId)
        .collection('Division')
        .doc(currentDivisionId)
        .collection('Students')
        .doc(cUserId)
        .set({
      'First Name': '$sFirstName',
      'Last Name': '$sLastName',
      'Enrollment No': '$sEnrollment',
      'role': 'student',
      'Email': '$sEmail',
    });
  }

  @override
  void initState() {
    super.initState();
    academicYearData();
    currentAcademicYearId = null;
    currentDepartmentValue = null;
    currentDivisionValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Form(
        key: _form,
        child: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BottomWave(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 8),
                        color: Colors.blueAccent,
                        height: 110.0,
                        width: 10.0,
                      ),
                      Container(
                        height: 115,
                        margin: EdgeInsets.only(left: 20, top: 8),
                        child: Text(
                          'ONLINE\nSTUDENT\nFEEDBACK\nSYSTEM',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(20, 10, 16, 5),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                          color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                prefixIcon: Icon(Icons.account_circle_outlined),
                              ),
                              onChanged: (text) {
                                sFirstName = text;
                              },
                              validator: (text) {
                                if (text.isEmpty) {
                                  return "Enter First Name ";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                prefixIcon: Icon(Icons.account_circle_outlined),
                              ),
                              onChanged: (text) {
                                sLastName = text;
                              },
                              validator: (text) {
                                if (text.isEmpty) {
                                  return "Enter Last Name ";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Enrollment No.',
                                prefixIcon: Icon(Icons.assignment_ind_outlined),
                              ),
                              validator: (text) {
                                if ((text.length != 12)) {
                                  return "Enter valid Enrollment ";
                                }
                                return null;
                              },
                              onChanged: (text) {
                                sEnrollment = text;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (text) {
                                if (!(text.contains('@')) && text.isEmpty) {
                                  return "Enter a valid email address!";
                                }
                                return null;
                              },
                              onChanged: (text) {
                                sEmail = text;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (val) =>
                                  val.length < 6 ? 'Password too short.' : null,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              onChanged: (text) {
                                sPassword = text;
                              },
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                    child: Text('ACADEMIC YEAR',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700))),
                                Expanded(
                                  child: simpleDropdown(
                                      currentAcademicYearValue,
                                      academicYearList,
                                      'Choose Academic Year', (value) {
                                    setState(() {
                                      currentAcademicYearId = academicYearMap
                                          .keys
                                          .firstWhere((element) =>
                                              academicYearMap[element] ==
                                              value);
                                      currentAcademicYearValue = value;
                                      deparmentData();
                                    });
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'DEPARTMENT',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Expanded(
                                  child: simpleDropdown(
                                      currentDepartmentValue,
                                      departmentList,
                                      'Choose Department', (value) {
                                    setState(() {
                                      currentDepartmentId = departmentMap.keys
                                          .firstWhere((element) =>
                                              departmentMap[element] == value);
                                      currentDepartmentValue = value;
                                      divisionData();
                                    });
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'DIVISION',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                                Expanded(
                                  child: simpleDropdown(currentDivisionValue,
                                      divisionList, 'Choose Division', (value) {
                                    setState(() {
                                      currentDivisionId = divisionMap.keys
                                          .firstWhere((element) =>
                                              divisionMap[element] == value);
                                      currentDivisionValue = value;
                                    });
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10, left: 115, right: 115, bottom: 18),
                              child: SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(5),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      _saveForm();
                                      try {
                                        final newUser = await _auth
                                            .createUserWithEmailAndPassword(
                                                email: sEmail,
                                                password: sPassword);
                                        if (newUser != null) {
                                          var cUserId = newUser.user.uid;
                                          addStudentToUser(cUserId);
                                          addStudentToDivision(cUserId);
                                          Navigator.pushNamed(
                                              context, loginScreenRoute);
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: Text(
                                      'SignIn',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class BottomWave extends StatelessWidget {
  const BottomWave({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      isLoop: false,
      config: CustomConfig(
        gradients: [
          [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
          [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
          [Color(0xFFfc00ff), Color(0xFF00dbde)],
          [Color(0xFF396afc), Color(0xFF2948ff)]
        ],
        durations: [1, 2, 3, 4],
        heightPercentages: [0.05, 0.07, 0.10, 0.15],
        blur: MaskFilter.blur(BlurStyle.inner, 5),
        gradientBegin: Alignment.centerLeft,
        gradientEnd: Alignment.centerRight,
      ),
      waveAmplitude: 1.0,
      backgroundColor: null,
      size: Size(double.infinity, 50.0),
    );
  }
}
