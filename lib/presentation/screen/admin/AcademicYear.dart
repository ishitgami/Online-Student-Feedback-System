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
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  //Provider
  AdminProvider collegedata;
  AdminData adminData;

  var userUid;
  var acYearList;
  var acYearKeyList;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

    // collegedata.fetchAdminData().then((value) {
    //   adminData = value;
    //   acYearList = adminData.acYear;
    //   userUid = adminData.uid;
    // });

    collegedata.getAcademicYear().then((value) {
      // print(value);
      acYearList = value.entries.map((entry) => "${entry.value}").toList();
      acYearKeyList = value.entries.map((entry) => "${entry.key}").toList();
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
              itemCount: acYearList == null ? 0 : acYearList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            acYearList.elementAt(index).toString(),
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
                                          acYearKeyList
                                              .elementAt(index)
                                              .toString());
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
