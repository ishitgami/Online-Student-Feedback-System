import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osfs1/commanWidget/logoContainer.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FacultyRegScreen extends StatefulWidget {

  @override
  _FacultyRegScreenState createState() => _FacultyRegScreenState();
}

class _FacultyRegScreenState extends State<FacultyRegScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Column(
          children: [
             LogoHeading(),
             Expanded(
               child: StreamBuilder(
                 stream: firestore.collection('Users').where('role',isEqualTo: 'Admin').snapshots(),
                 builder: (context,snapshot){
                   List<dynamic> data = snapshot.data.docs;
                  //  List<dynamic> data = snapshot.data.document.map((e) => e.data()).toList();
                  
                   print(snapshot.data.docs[0]['InstitudeName']);
                   return Text('');
                 },
               ),
             ),
          ],
        ) 
        ),
    );
  }
}