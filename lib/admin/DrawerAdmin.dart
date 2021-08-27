import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            _createHeader(),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.dashboard,color: Colors.blue,),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Dashbord'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AdminScreen.id);
              },
            ),
            SizedBox(
              width: 50,
              child: Divider()),
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
              title: Row(
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

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('img/drawerbg.jpg'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Row(
              children: [
                 Text(
                  "Admin",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 38.0,
                      fontWeight: FontWeight.w700), 
                ),
                SizedBox(
                  width: 100,
                ),
                Icon(FontAwesomeIcons.userCog,size: 50),
              ],
            )),
      ]));
}
