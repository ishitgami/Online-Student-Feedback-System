import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'DrawerAdmin.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

    collegedata.fetchAdminData().then((value) {
      adminData = value;
      acYearList = adminData.acYear;
      userUid = adminData.uid;
    });

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
                        collegedata.addAcYead(
                            adminData.uid, academicYear1 + '-' + academicYear2);
                        _controller1.clear();
                        _controller2.clear();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('ADD')),
              ],
            ),
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
                                          adminData.uid,
                                          acYearList
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
