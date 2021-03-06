import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:provider/provider.dart';
import 'DrawerAdmin.dart';
import 'addDepartment.dart';

class DepartmentScreen extends StatefulWidget {
  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {

  //Provider
  AdminProvider collegedata;
  AdminData adminData;

  var getUser;
  var departmentList;
  var departmentKeyList;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);
    // getUser = collegedata.getCurrentUser();

    // collegedata.fetchAdminData().then((value) {
    //   //  setState(() {
    //   adminData = value;
    //   departmentList = adminData.department;
    //   getUser = adminData.uid;
    //   //  });
    // });

    collegedata.getDepartment().then((value) {
      // print(value);
      departmentList = value.entries.map((entry) => "${entry.value}").toList();
      departmentKeyList = value.entries.map((entry) => "${entry.key}").toList();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Department'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(context,  MaterialPageRoute(builder: (context) => AddDepartmentScreen()));
        },
        child: Icon(Icons.add),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: departmentList == null ? 0 : departmentList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            departmentList.elementAt(index).toString(),
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
                                      collegedata.deleteDepartment(
                                          departmentKeyList
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
            //  ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: departmentList ,
            //         itemBuilder: (context, index) {
            //           return Card(
            //             margin: EdgeInsets.all(8),
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Row(
            //                 children: [
            //                   Expanded(
            //                     child: Text(
            //                       adminData
            //                           .toJson()['department']
            //                           .elementAt(index)
            //                           .toString(),
            //                       style: TextStyle(fontSize: 22.0),
            //                     ),
            //                   ),
            //                   IconButton(
            //                     alignment: Alignment.centerLeft,
            //                     icon: Icon(Icons.delete),
            //                     onPressed: () {
            //                       showDialog(
            //                         context: context,
            //                         builder: (_) => AlertDialog(
            //                           content: Text(
            //                               "Are you sure you want to delete ?"),
            //                           actions: [
            //                             TextButton(
            //                               child: Text(
            //                                 "Cancel",
            //                                 style:
            //                                     TextStyle(color: Colors.black),
            //                               ),
            //                               onPressed: () {
            //                                 Navigator.of(context).pop();
            //                               },
            //                             ),
            //                             TextButton(
            //                               child: Text(
            //                                 "Delete",
            //                                 style: TextStyle(color: Colors.red),
            //                               ),
            //                               onPressed: () {
            //                                 collegedata.deleteDepartment(
            //                                     getUser,
            //                                     departmentList
            //                                         .elementAt(index)
            //                                         .toString());
            //                                 Navigator.of(context).pop();
            //                               },
            //                             ),
            //                           ],
            //                         ),
            //                       );
            //                     },
            //                   )
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       )
               
                  
          ],
        ),
      ),
    );
  }
}
