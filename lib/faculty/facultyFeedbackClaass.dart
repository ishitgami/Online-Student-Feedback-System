import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FacultyFeedClassScreen extends StatefulWidget {
  FacultyFeedClassScreen({this.feedbackClassId});
  final String feedbackClassId;
  @override
  _FacultyFeedClassScreenState createState() => _FacultyFeedClassScreenState(feedbackClassId);
}

class _FacultyFeedClassScreenState extends State<FacultyFeedClassScreen> {
   final String feedbackClassId;
  _FacultyFeedClassScreenState(this.feedbackClassId);

  final auth = FirebaseAuth.instance;
  User user;
  var uid;
  List _listPages;
  int _page = 0;

  void initState() {
    _listPages = [
      FclassHome(feedbackClassId: feedbackClassId),
      FSceen(feedbackClassId: feedbackClassId),
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Students'),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body:  _listPages[_page],
    );
  }
}


class FSceen extends StatelessWidget {
  const FSceen({
    Key key,
    @required this.feedbackClassId,
  }) : super(key: key);

  final String feedbackClassId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: firestore
            .collection('FeedbackClass')
            .where('Id', isEqualTo: feedbackClassId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var dataaa = snapshot.data.docs;
            print('Dataaaa-->$dataaa');
            List<dynamic> data =
                snapshot.data.docs.map((e) => e.data()).toList();
            // print('Dataaaa-->$data');
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: data[0]['StudentList'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: StreamBuilder(
                      stream: firestore
                          .collection('Users')
                          .doc(data[0]['StudentList'][index])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new CircularProgressIndicator();
                        }
                        var document = snapshot.data;
                        return Text(document['PersonalInfo']['First Name'] +
                            ' ' +
                            document['PersonalInfo']['Last Name']);
                      },
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}



class FclassHome extends StatefulWidget {
  const FclassHome({
    @required this.feedbackClassId,
  });
  final String feedbackClassId;

  @override
  _FclassHomeState createState() =>
      _FclassHomeState(feedbackClassId: feedbackClassId);
}

class _FclassHomeState extends State<FclassHome> {
  _FclassHomeState({this.feedbackClassId});
  final String feedbackClassId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              FormBuilder(
                child: Column(
                  children: [
                    FormBuilderFilterChip(
                name: 'filter_chip',
                decoration: InputDecoration(
                  labelText: 'Select many options',
                ),
                options: [
                  FormBuilderFieldOption(
                      value: 'Test', child: Text('Test')),
                  FormBuilderFieldOption(
                      value: 'Test 1', child: Text('Test 1')),
                  FormBuilderFieldOption(
                      value: 'Test 2', child: Text('Test 2')),
                  FormBuilderFieldOption(
                      value: 'Test 3', child: Text('Test 3')),
                  FormBuilderFieldOption(
                      value: 'Test 4', child: Text('Test 4')),
                ],
              ),
                  ],
                )
              
              )
            ],
          )
          
        ),
      ),
    );
  }
}
