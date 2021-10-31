import 'package:flutter/material.dart';
import 'package:osfs1/faculty/FacultyDashbord.dart';
import 'package:osfs1/route.dart';

class FacultyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
           padding: EdgeInsets.zero,
          children: <Widget>[
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
                Navigator.pushNamed(context,FacultyDashbordScreenRoute);
              },
            ),
            SizedBox(width: 50, child: Divider()),
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
                  Text('Feedback Class'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context,FacultyFclassScreenRoute);
              },
            ),
          ]
        ),
       )
    );
  }
}