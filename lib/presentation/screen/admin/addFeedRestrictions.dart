import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:provider/provider.dart';

class AddFeedbackRestriction extends StatefulWidget {
  @override
  State<AddFeedbackRestriction> createState() => _AddFeedbackRestrictionState();
}

class _AddFeedbackRestrictionState extends State<AddFeedbackRestriction> {
  //Provider
  AdminProvider collegedata;

  List academicYearMapList;
  List departmentMapList;
  List subjectMapList;
  List facultyMapList;
  var _selectedAcYear;
  var _selectedDepartment;
  var _selectedSubject;
  var _selectedFaculty;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

    collegedata.getAcademicYear().then((value) {
      setState(() {
        academicYearMapList = value;
      });
    });

    collegedata.getDepartment().then((value) {
      setState(() {
        departmentMapList = value;
      });
    });

    collegedata.getSubject().then((value) {
      setState(() {
        subjectMapList = value;
      });
    });

    collegedata.getFaculty().then((value) {
      setState(() {
        facultyMapList = value;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Feedback Restriction'),
      ),
      body: SafeArea(
        child: academicYearMapList == null ||
                departmentMapList == null ||
                facultyMapList == null ||
                subjectMapList == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Academic Year',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
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
                              items: academicYearMapList.map((acYear) {
                                return DropdownMenuItem(
                                  child: new Text(acYear['Year']),
                                  value: acYear['Year'],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Department',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                              items: departmentMapList.map((map) {
                                return DropdownMenuItem(
                                  child: new Text(map['Department']),
                                  value: map['Department'],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subject',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              dropdownColor: Colors.grey[100],
                              iconEnabledColor: Colors.black,
                              hint: Text('Subject',
                                  style: TextStyle(
                                      color: Colors
                                          .black)), // Not necessary for Option 1
                              value: _selectedSubject,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedSubject = newValue;
                                });
                              },
                              items: subjectMapList.map((map) {
                                return DropdownMenuItem(
                                  child:
                                      new Text(map['Code'] + ' ' + map['Name']),
                                  value: map['Code']+' '+ map['Name'],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Faculty',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              dropdownColor: Colors.grey[100],
                              iconEnabledColor: Colors.black,
                              hint: Text('Faculty',
                                  style: TextStyle(
                                      color: Colors
                                          .black)), // Not necessary for Option 1
                              value: _selectedFaculty,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedFaculty = newValue;
                                });
                              },
                              items: facultyMapList.map((map) {
                                return DropdownMenuItem(
                                  child: new Text(map['Name']),
                                  value: map['id'],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:10 ,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(7),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          print(_selectedFaculty);
                          print(_selectedAcYear);
                          print(_selectedSubject);
                          print(_selectedDepartment);
                        },
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
