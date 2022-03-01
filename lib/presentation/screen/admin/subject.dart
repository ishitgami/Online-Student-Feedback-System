import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:provider/provider.dart';
import 'DrawerAdmin.dart';

class SubjectScreen extends StatefulWidget {
  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //Provider
  AdminProvider collegedata;
  //model
  AdminData adminData;

  User loggedInUser;
  var orgCode;

  List semester = ['1','2','3','4','5','6','7','8'];
  List departmentList;
  String _selectedDepartment;
  var selectesSemester;
  var subjectCode;
  var subjectName;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

     
   collegedata.fetchAdminData().then((value) {
     setState(() {
        adminData = value;
       departmentList = adminData.department;
       orgCode = adminData.orgCode;
     });
      
   });

    

    return Scaffold(
      appBar: AppBar(
        title: Text('Subject'),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: Colors.grey[100],
                        iconEnabledColor: Colors.black,
                        hint: Text('Department',
                            style: TextStyle(
                                color:
                                    Colors.black)), // Not necessary for Option 1
                        value: _selectedDepartment,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDepartment = newValue;
                          });
                        },
                        items: departmentList == null
                            ? []
                            : departmentList.map((acYear) {
                                return DropdownMenuItem(
                                  child: new Text(acYear),
                                  value: acYear,
                                );
                              }).toList(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: Colors.grey[100],
                        iconEnabledColor: Colors.black,
                        hint: Text('Semester',
                            style: TextStyle(
                                color:
                                    Colors.black)), // Not necessary for Option 1
                        value: selectesSemester,
                        onChanged: (newValue) {
                          setState(() {
                            selectesSemester = newValue;
                          });
                        },
                        items: semester == null
                            ? []
                            : semester.map((semester) {
                                return DropdownMenuItem(
                                  child: new Text(semester),
                                  value: semester,
                                );
                              }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Subject Code'),
                    onChanged: (text) {
                      subjectCode = text;
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller2,
                    decoration: InputDecoration(labelText: 'Subject Name'),
                    onChanged: (text) {
                      subjectName = text;
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      collegedata.addSubject(adminData.uid,
                          _selectedDepartment, subjectCode, subjectName,selectesSemester);
                    },
                    child: Text('ADD'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
