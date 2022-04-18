import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:provider/provider.dart';


class AddSubjectSceen extends StatefulWidget {

  @override
  State<AddSubjectSceen> createState() => _AddSubjectSceenState();
}

class _AddSubjectSceenState extends State<AddSubjectSceen> {
    TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //Provider
  AdminProvider collegedata;
  //model
  AdminData adminData;

  User loggedInUser;
  var orgCode;

  List semester = ['1', '2', '3', '4', '5', '6', '7', '8'];
  List departmentKeyList;
  List departmentList;
  String _selectedDepartment;
  var selectesSemester;
  var subjectCode;
  var subjectName;
  @override
  Widget build(BuildContext context) {
     collegedata = Provider.of<AdminProvider>(context);
    collegedata.getDepartment().then((value) {
      departmentList = value.entries.map((entry) => "${entry.value}").toList();
      departmentKeyList = value.entries.map((entry) => "${entry.key}").toList();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subject'),
      ),
        body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
                          color: Colors
                              .black)), // Not necessary for Option 1
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
            SizedBox(
              height: 30,
            ),
            Container(
               padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
                          color: Colors
                              .black)), // Not necessary for Option 1
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
             SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Subject Code'),
              onChanged: (text) {
                subjectCode = text;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(labelText: 'Subject Name'),
              onChanged: (text) {
                subjectName = text;
              },
            ),
            SizedBox(
             height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('BACK')),
                    SizedBox(
                      width: 20,
                    ),
                ElevatedButton(
                    onPressed: () {
                      collegedata.addSubject( _selectedDepartment,
                          subjectCode, subjectName, selectesSemester);
                          Navigator.pop(context);
                    },
                    child: Text('ADD')),
              ],
            )
          ],
        ),
      ),
    );
  }
}