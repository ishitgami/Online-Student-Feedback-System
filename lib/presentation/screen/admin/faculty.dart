import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:provider/provider.dart';
import 'DrawerAdmin.dart';


class FacultyInAdmin extends StatefulWidget {
  @override
  _FacultyInAdminState createState() => _FacultyInAdminState();
}

class _FacultyInAdminState extends State<FacultyInAdmin> {
    //Provider
  AdminProvider collegedata;


  var facultyMapList;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

    collegedata.getFaculty().then((value) {
      setState(() {
        facultyMapList = value;
      });
      
    });




    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty'),
      ),
    drawer: AdminDrawer(),
      body: SafeArea(
        child:Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: facultyMapList == null ? 0 : facultyMapList.length,
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
                              facultyMapList.elementAt(index)['Name'].toString(),
                              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
                            ),
                             Text(
                              facultyMapList.elementAt(index)['Email'].toString(),
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
                                      collegedata.deleteSubject(facultyMapList.elementAt(index)['id'].toString());
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
        ),
    );
  }
}