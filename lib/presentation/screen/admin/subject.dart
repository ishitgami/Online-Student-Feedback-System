import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/presentation/screen/admin/addSubject.dart';
import 'DrawerAdmin.dart';
import 'package:provider/provider.dart';

class SubjectScreen extends StatefulWidget {
  @override
  _AcademicYearState createState() => _AcademicYearState();
}

class _AcademicYearState extends State<SubjectScreen> {

  //Provider
  AdminProvider collegedata;
  AdminData adminData;

  var subjectMapList;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

    collegedata.getSubject().then((value) {
      subjectMapList = value;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Subject'),
      ),
      drawer: AdminDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => AddSubjectSceen()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: subjectMapList == null ? 0 : subjectMapList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subjectMapList.elementAt(index)['Code'].toString(),
                              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              subjectMapList.elementAt(index)['Name'].toString(),
                              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
                            ),
                             Text(
                              subjectMapList.elementAt(index)['Semester'].toString() + ' '
                              + subjectMapList.elementAt(index)['Department'].toString(),
                              style: TextStyle(fontSize: 14.0,),
                            ),
                          ],
                        ),
                        Spacer(),
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
                                      collegedata.deleteSubject(subjectMapList.elementAt(index)['id'].toString());
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
