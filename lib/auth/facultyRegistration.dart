import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osfs1/commanWidget/logoContainer.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FacultyRegScreen extends StatefulWidget {
  @override
  _FacultyRegScreenState createState() => _FacultyRegScreenState();
}

class _FacultyRegScreenState extends State<FacultyRegScreen> {
  var _dchosenValue;
  var currentOrgId;

  orgnazitionMap(data) {
    Map orgList = {};
    data.forEach((element) {
      orgList.putIfAbsent(element['UId'], () => element['InstituteName']);
    });
    return orgList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          LogoHeading(),
          Column(
            children: [
              
            ],
          ),
        ],
      )),
    );
  }
}
