import 'package:flutter/material.dart';
import 'package:osfs1/presentation/screen/admin/addFeedRestrictions.dart';
import 'DrawerAdmin.dart';


class RestrictionsScreen extends StatefulWidget {
  @override
  _RestrictionsScreenState createState() =>
      _RestrictionsScreenState();
}

class _RestrictionsScreenState
    extends State<RestrictionsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Restrictions'),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => AddFeedbackRestriction()));
      },
      child: Icon(Icons.add),
      ),
      drawer: AdminDrawer(),
      body: Container(
        child: Text('Feedback Restrication'),
      )
    );
  }
}
