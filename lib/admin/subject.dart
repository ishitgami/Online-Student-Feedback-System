import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'DrawerAdmin.dart';

class SubjectScreen extends StatefulWidget {

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
   FirebaseFirestore firestore = FirebaseFirestore.instance;

  var subjectCode;
  var subjectName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subject'),),
       drawer: AdminDrawer(),
       body: Container(
          margin: EdgeInsets.all(16),
         child:Column(
           children: [
             Row(
               children: [
                 Expanded(
                   child: TextField(
                      controller: _controller1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Subject Code'),
                      onChanged: (text) {
                        subjectCode = text;
                      },
                    ),
                 ),
                 SizedBox(
                    width: 30,
                  ),
                 Expanded(
                   child: TextField(
                      controller: _controller2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Subject Name'),
                      onChanged: (text) {
                        subjectName = text;
                      },
                    ),
                 ),
                 SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      firestore.collection('Subjects').add({
                        'name' : subjectCode + '_' + subjectName
                      });
                    }, 
                    child: Text('ADD')
                    )
               ],
             )
           ],
         ) ,
       ),
    );
  }
}