import 'package:flutter/material.dart';
import 'package:osfs1/getData/getAcademicYear.dart';
import 'package:osfs1/getData/getDepartment.dart';
import 'DrawerAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/simpleDropdown.dart';

class DepartmentScreen extends StatefulWidget {

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _controller = TextEditingController();

  List<dynamic> academicYearList;
  List<dynamic> departmentList;

  Map academicYearMap;
  Map departmentMap;

  var currentAcademicYearValue;
  var currentDepartmentValue;
  var currentAcademicYearId;
  var currentDepartmentId;
  var addDepartment;

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
                departmentList.add(value);
              })
            });
    return departmentMap;
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
        title: Text('Department'),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('ACADEMIC YEAR')),
                Expanded(
                  child: simpleDropdown(currentAcademicYearValue, academicYearList,
                      'choose Academic Year', (value) {
                    setState(() {
                      currentAcademicYearId = academicYearMap.keys.firstWhere(
                          (element) => academicYearMap[element] == value);
                      currentAcademicYearValue = value;
                    });
                  }),
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
                      labelText: 'ADD DEPARTMENT',
                    ),
                    onChanged: (text) {
                      addDepartment = text;
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
                              .add({
                            'name': addDepartment,
                          });
                        });
                        _controller.clear();
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: FutureBuilder(
                future: deparmentData(),
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
                        itemCount: departmentMap.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      departmentMap.values
                                          .elementAt(index)
                                          .toString(),
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
                                                      Navigator.of(context)
                                                          .pop();
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
                                                            .collection('Academic Year')
                                                            .doc(currentAcademicYearId)
                                                            .collection('Department')
                                                            .doc(departmentMap.keys.elementAt(index))
                                                            .delete()
                                                            .then((_) => print('Deleted'))
                                                            .catchError((error) => print('Delete failed: $error'));
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
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
}
