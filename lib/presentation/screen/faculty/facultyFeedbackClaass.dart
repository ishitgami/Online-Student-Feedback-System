import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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





