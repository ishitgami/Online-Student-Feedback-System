import 'package:flutter/material.dart';
import 'faculty.dart';
import 'index.dart';
import 'AcademicYear.dart';
import 'student.dart';
import 'Department.dart';
import 'classes.dart';
import 'subject.dart';
import 'feedbackRestrictions.dart';
import 'feedbackQue.dart';
import 'report.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
       child: SafeArea(
         child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Dashbord'),
              onTap: () {
                 Navigator.pop(context);
                Navigator.pushNamed(context,  AdminScreen.id);
              },
            ),
            ListTile(
              title: Text('Academic Year'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AcadamicYear.id);
              },
            ),
            ListTile(
              title: Text('DepartMent'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Department.id);
              },
            ),
            ListTile(
              title: Text('Division'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ClassScreen.id);
              },
            ),
            ListTile(
              title: Text('Subject'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Subject.id);
              },
            ),
            ListTile(
              title: Text('Feedback Question'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, FeedbackQue.id);
              },
            ),
            ListTile(
              
              title:Row(
                children: [
                  Expanded(child: Text('Feedback Restrictions')),
                  Icon(Icons.adjust),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, FeedbackRestrictionsScreen.id);
              },
            ),
             ListTile(
              title: Text('Feedback Report'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ReportScreen.id);
              },
            ),
            ListTile(
              title: Text('Faculty'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, FacultyInAdmin.id);
              },
            ),
            
             ListTile(
              title: Text('Student'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, StudentInAdminScreen.id);
              },
            ),
             
          ],
      ),
       ),
    );
  }
}
