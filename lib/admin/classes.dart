import 'package:flutter/material.dart';
import 'package:osfs1/getData/getAcademicYear.dart';
import 'package:osfs1/getData/getDepartment.dart';
import 'package:osfs1/getData/getDivision.dart';
import 'DrawerAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/simpleDropdown.dart';


class Divisioncreen extends StatefulWidget {

  @override
  _DivisioncreenState createState() => _DivisioncreenState();
}

class _DivisioncreenState extends State<Divisioncreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _controller = TextEditingController();

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
  var addDivision;

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
                divisionList.add(value);
              })
            });
    return divisionMap;
  }

  @override
  void initState() {
    super.initState();
    academicYearData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes'),
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
                )),
                Expanded(
                  child: simpleDropdown(currentAcademicYearValue,
                      academicYearList, 'choose Academic Year', (value) {
                    setState(() {
                      currentAcademicYearId = academicYearMap.keys.firstWhere(
                          (element) => academicYearMap[element] == value);
                      currentAcademicYearValue = value;
                      currentDepartmentValue = null;
                      deparmentData();
                    });
                  },
                  ),
                  
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
                )),
                Expanded(
                  child: simpleDropdown(currentDepartmentValue, departmentList,
                      'choose department', (value) {
                    setState(() {
                      currentDepartmentId = departmentMap.keys.firstWhere((element) => departmentMap[element] == value);
                      currentDepartmentValue = value;
                    });
                  },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'ADD DIVISION',
                    ),
                    onChanged: (text) {
                      addDivision = text;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent, shape: BoxShape.rectangle),
                    child: GestureDetector(
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          firestore
                              .collection('Academic Year')
                              .doc(currentAcademicYearId)
                              .collection('Department')
                              .doc(currentDepartmentId)
                              .collection('Division')
                              .add({
                            'name': addDivision,
                          });
                        });
                        _controller.clear();
                      },
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: divisionData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occured',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: divisionMap.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      divisionMap.values
                                          .elementAt(index)
                                          .toString(),
                                      style: TextStyle(fontSize: 22.0),
                                    ),
                                  ),
                                  IconButton(
                                    alignment: Alignment.centerLeft,
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        firestore
                                            .collection('Academic Year')
                                            .doc(currentAcademicYearId)
                                            .collection('Department')
                                            .doc(currentDepartmentId)
                                            .collection('Division')
                                            .doc(divisionMap.keys
                                                .elementAt(index))
                                            .delete()
                                            .then((_) => print('Deleted'))
                                            .catchError((error) =>
                                                print('Delete failed: $error'));
                                      });
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
}