import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/getData/getAcademicYear.dart';
import 'DrawerAdmin.dart';

class AcadamicYear extends StatefulWidget {
  static String id = 'classes screen';

  @override
  _AcademicYearState createState() => _AcademicYearState();
}

class _AcademicYearState extends State<AcadamicYear> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  Map academicYearMap;

  var currentAcademicYearId;
  var academicYear1;
  var academicYear2;

  Future academicYearData() async {
    await GetAcademicYearData().getAcademicYear().then((value) => {
          academicYearMap = value,
        });
    return academicYearMap;
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
          title: Text('Academic Year'),
        ),
        drawer: AdminDrawer(),
        body: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Start Year'),
                      onChanged: (text) {
                        academicYear1 = text;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'End Year',
                      ),
                      onChanged: (text) {
                        academicYear2 = text;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          setState(() {
                            firestore.collection('Academic Year').add({
                              'Year': '$academicYear1' + '-' + '$academicYear2',
                            })
                            .then((value) => {
                                  value.collection('Department').add({
                                    'name': 'CIVIL ENGINEERING',
                                  }),
                                  value.collection('Department').add({
                                    'name': 'COMPUTER ENGINEERING',
                                  }),
                                  value.collection('Department').add({
                                    'name': 'ELECTRONICS & COMMUNICATION ENGG.',
                                  }),
                                  value.collection('Department').add({
                                    'name': 'INFORMATION TECHNOLOGY',
                                  }),
                                  value.collection('Department').add({
                                    'name': 'MECHANICAL ENGINEERING',
                                  }),
                                  value.collection('Department').add({
                                    'name': 'PRODUCTION ENGINEERING',
                                  }),
                                });
                          });
                          _controller1.clear();
                          _controller2.clear();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('ADD')),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: academicYearData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: academicYearMap.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      academicYearMap.values
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
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                                onPressed: () {
                                                setState(() {
                                        firestore
                                            .collection('Academic Year')
                                            .doc(academicYearMap.keys.elementAt(index))
                                            .delete()
                                            .then((_) => print('Deleted'))
                                            .catchError((error) =>
                                                print('Delete failed: $error'));
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
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
