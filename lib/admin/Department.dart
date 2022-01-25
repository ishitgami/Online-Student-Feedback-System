import 'package:flutter/material.dart';
import 'package:osfs1/Model/AdminModel.dart';
import 'package:osfs1/Model/collegeData.dart';
import 'package:provider/provider.dart';
import 'DrawerAdmin.dart';


class DepartmentScreen extends StatefulWidget {
  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  TextEditingController _controller = TextEditingController();

  //Provider
  CollegeData collegedata;
   AdminData adminData;

  var getUser;
  var departmentList;
  var departmentName;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<CollegeData>(context);
    getUser = collegedata.getCurrentUser();

    collegedata.fetchAdminData().then((value) {
     setState(() {
       adminData = value.first;
       departmentList = adminData.department;
     });
   });

  
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
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Department Name'),
                    onChanged: (text) {
                      departmentName = text;
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        collegedata.addDepartmentData(
                            getUser.uid, departmentName);
                        _controller.clear();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('ADD')),
              ],
            ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: departmentList==null?0:departmentList.length,
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
                                      content: Text(
                                          "Are you sure you want to delete ?"),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.black),
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
                                                getUser.uid,
                                                departmentList
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
