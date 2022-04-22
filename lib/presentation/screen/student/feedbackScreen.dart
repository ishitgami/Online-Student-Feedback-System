import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/presentation/router/route.dart';
import 'package:provider/provider.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen(this.feedbackId);
  var feedbackId;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState(feedbackId);
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  _FeedbackScreenState(this.feedbackClassId);
  String feedbackClassId;
  AdminProvider collegedata;
  var feedbackClassMapList;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

    collegedata.getFeedbackClassQue(feedbackClassId).then((value) {

      setState(() {
        feedbackClassMapList = value;
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: feedbackClassMapList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  feedbackClassMapList[index]['question']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(feedbackQueMapList[index]['question']);
                                    //  firestore
                                    //   .collection('Academic Year')
                                    //   .doc(currentAcademicYearId)
                                    //   .collection('Department')
                                    //   .doc(currentDepartmentId)
                                    //   .collection('Division')
                                    //   .doc(currentDivisionId)
                                    //   .collection('feedback')
                                    //   .doc(feedbackId)
                                    //   .collection('questions')
                                    //   .doc(feedbackQueMapList[index]['id'])
                                    //   .update({
                                    //     'rating.'+currentStudentId : rating

                                    //   });

                                    // .collection('rating')
                                    // .doc(currentStudentId)
                                    // .set({
                                    //   'rate' : rating
                                    // });

                                    // firestore
                                    // .collection('faculty')
                                    // .doc(currentFacultyId)
                                    // .collection('feedback')
                                    // .doc(feedbackId)
                                    // .collection('questions')
                                    // .doc(feedbackQueMapList[index]['id'])
                                    // .update({
                                    //   'rating.'+currentStudentId : rating

                                    // });
                                    // .collection('rating')
                                    // .doc(currentStudentId)
                                    // .set({
                                    //   'rate' : rating
                                    // });

                                    // firestore
                                    // .collection('feedback')
                                    // .doc(feedbackId)
                                    // .collection('questions')
                                    // .doc(feedbackQueMapList[index]['id'])
                                    // .update({
                                    //   'rating.'+currentStudentId : rating

                                    // });
                                    // .collection('rating')
                                    // .doc(currentStudentId)
                                    // .set({
                                    //   'rate' : rating
                                    // });

                                    // firestore
                                    // .collection('faculty')
                                    // .doc(currentFacultyId)
                                    // .collection('feedback')
                                    // .doc(feedbackId)
                                    // .collection('questions')
                                    // .doc(feedbackQueMapList[index]['id'])
                                    // .update({
                                    //   'rating.'+currentStudentId : rating

                                    // });
                                    // .collection('rating')
                                    // .doc(currentStudentId)
                                    // .set({
                                    //   'rate' : rating
                                    // });

                                    print(rating);
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    print(currentStudentId);
                    // setState(() {
                    // firestore
                    // .collection('Academic Year')
                    // .doc(currentAcademicYearId)
                    // .collection('Department')
                    // .doc(currentDepartmentId)
                    // .collection('Division')
                    // .doc(currentDivisionId)
                    // .collection('feedback')
                    // .doc(feedbackId)
                    // .update({

                    //   'submitted.' + currentStudentId : true
                    // });
                    // });
                    Navigator.pushNamed(context, studentScreenRoute);
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
