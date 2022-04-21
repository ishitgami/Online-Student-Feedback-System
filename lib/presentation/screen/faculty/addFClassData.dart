import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/presentation/screen/faculty/studentListScreen.dart';
import 'package:provider/provider.dart';

class AddFclassData extends StatefulWidget {
  @override
  _AddFclassDataState createState() => _AddFclassDataState();
}

class _AddFclassDataState extends State<AddFclassData> {
  String fClassName;
  String fClassDescription;

  var orgCode;
  var studentTotal;
  var facultyTotal;
  var subject;
  var selectesSemester;
  List departmentList;
  List _acYearList;
  String _selectedAcYear;
  String _selectedDepartment;
  List subjectList;
  List semester = ['1','2','3','4','5','6','7','8'];

  AdminData adminData;
  AdminProvider collegedata;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);
 
    // collegedata.fetchAdminDatForFaculty().then((value) {
    //   //  setState(() {
    //   adminData = value;
    //   _acYearList = adminData.acYear;
    //   departmentList = adminData.department;
    //   orgCode = adminData.orgCode;
    //   // subject = adminData.subject;
    //   // subjectList= subject[_selectedDepartment][selectesSemester].toList();
    //   // print('subjectList--->$subjectList');
    //   //  });
    // });

    

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add\nFeedBackClass',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  onChanged: (value) {
                    fClassName = value;
                  },
                  decoration: InputDecoration(
                    label: Text('FeedbackClass Name'),
                  )),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  fClassName = value;
                },
                decoration: InputDecoration(
                  label: Text('FeedbackClass Description'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                          dropdownColor: Colors.grey[100],
                          iconEnabledColor: Colors.black,
                          hint: Text('Acedemic Year',
                              style: TextStyle(
                                  color: Colors
                                      .black)), // Not necessary for Option 1
                          value: _selectedAcYear,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedAcYear = newValue;
                            });
                          },
                          items: _acYearList == null
                              ? []
                              : _acYearList.map((acYear) {
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
                              : departmentList.map((department) {
                                  return DropdownMenuItem(
                                    child: new Text(department),
                                    value: department,
                                  );
                                }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                SizedBox(
                height: 10,
              ),
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: FutureBuilder(
                      builder: (context,snapshot) {
                        print(snapshot.data);
                        return DropdownButtonHideUnderline(
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
                            items: subject == null
                                ? []
                                : departmentList.map((acYear) {
                                    return DropdownMenuItem(
                                      child: new Text(acYear),
                                      value: acYear,
                                    );
                                  }).toList(),
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancle',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentListScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
