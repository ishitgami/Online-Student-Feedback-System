import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class FeedbackClassScreen extends StatelessWidget {
  FeedbackClassScreen({this.feedbackClassId});
  final String feedbackClassId;
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: firestore
                .collection('FeedbackClass')
                .where('Id', isEqualTo: feedbackClassId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> data =
                    snapshot.data.docs.map((e) => e.data()).toList();
                return ListView.builder(
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
                  },
                );
              }
              return Text('Its Error!');
            },
          ),
        )
      ],
    ));
  }
}
