import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../route.dart';


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
            // _createHeader(),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.dashboard,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Dashbord'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context,AdminScreenRoute);
              },
            ),
            SizedBox(width: 50, child: Divider()),
            Container(
              margin: EdgeInsets.only(left: 20, top: 5),
              child: Text(
                'COLLAGE',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendarAlt,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Academic Year'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context,acadamicYearScreenRoute);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.networkWired,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('DepartMent'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, departmentScreenRoute);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.book,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Subject'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, subjectScreenRoute);
              },
            ),
             ListTile(
              title: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.chalkboardTeacher,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Faculty'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, facultyInAdminScreenRoute);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.userGraduate,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Student'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, studentInAdminScreenRoute);
              },
            ),
            SizedBox(width: 50, child: Divider()),
            Container(
              margin: EdgeInsets.only(left: 20, top: 5),
              child: Text(
                'FEEDBACK',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.quora,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Question'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, questionScreenRoute);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.server,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(child: Text('Restrictions')),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, restrictionsScreenRoute);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.filePdf,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Report'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, reportScreenRoute);
              },
            ),
            SizedBox(width: 50, child: Divider()),
          ],
        ),
      ),
    );
  }
}