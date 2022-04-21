import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'DrawerAdmin.dart';
import 'package:provider/provider.dart';

import 'addAcademicYearScreen.dart';

class AcadamicYearScreen extends StatefulWidget {
  @override
  _AcademicYearState createState() => _AcademicYearState();
}

class _AcademicYearState extends State<AcadamicYearScreen> {

  //Provider
  AdminProvider collegedata;
  var academicYearMapList;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

    collegedata.getAcademicYear().then((value) {
      academicYearMapList = value;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Year'),
      ),
      drawer: AdminDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => AddAcademicYearScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: academicYearMapList == null ? 0 : academicYearMapList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            academicYearMapList.elementAt(index)['Year'].toString(),
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
                                content:
                                    Text("Are you sure you want to delete ?"),
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
                                      collegedata.deleteAcYear(
                                         academicYearMapList.elementAt(index)['id'].toString(),);
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
            ),
          ],
        ),
      ),
    );
  }
}
