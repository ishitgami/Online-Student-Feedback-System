import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'package:osfs1/getData/getFeedbackQueByDivision.dart';
import 'package:osfs1/presentation/router/route.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FeedbackScreen extends StatelessWidget {
   FeedbackScreen({
     this.feedbackId,
     this.currentAcademicYearId,
     this.currentDepartmentId,
     this.currentDivisionId,
     this.currentStudentId,
     });
  final feedbackId;
  final currentAcademicYearId;
  final currentDepartmentId;
  final currentDivisionId;
  final currentStudentId;

  @override
  Widget build(BuildContext context) {
   

    Future getFeedbackque() async {
       print('currentFeedbackValue-->$feedbackId');
    feedbackQueMapList = [];
    await GetFeedbackQueByDivision(
      currentAcademicYearId: currentAcademicYearId,
      currentDepartmentId: currentDepartmentId,
      currentDivisionId: currentDivisionId,
      currentFeedbackId: feedbackId,
    ).getFeedbackQueByDivisionData().then((value) => {
      print('value-->$value'),
          // setState(() {
          feedbackQueMapList = value,
          // })
        });
    return feedbackQueMapList;
  }
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Column(
            children: [
              FutureBuilder(
                  future: getFeedbackque(),
                  builder: (context, snapshot) {
                    print(snapshot);
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(currentFacultyId);
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: feedbackQueMapList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.all(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            feedbackQueMapList[index]
                                                    ['question']
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
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.black,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(feedbackQueMapList[index]['id']);
                                               firestore
                                                .collection('Academic Year')
                                                .doc(currentAcademicYearId)
                                                .collection('Department')
                                                .doc(currentDepartmentId)
                                                .collection('Division')
                                                .doc(currentDivisionId)
                                                .collection('feedback')
                                                .doc(feedbackId)
                                                .collection('questions')
                                                .doc(feedbackQueMapList[index]['id'])
                                                .update({
                                                  'rating.'+currentStudentId : rating
                                                  
                                                });
                                                
                                                // .collection('rating')
                                                // .doc(currentStudentId)
                                                // .set({
                                                //   'rate' : rating
                                                // });
                                               
                                                firestore
                                                .collection('faculty')
                                                .doc(currentFacultyId)
                                                .collection('feedback')
                                                .doc(feedbackId)
                                                .collection('questions')
                                                .doc(feedbackQueMapList[index]['id'])
                                                .update({
                                                  'rating.'+currentStudentId : rating
                                                  
                                                });
                                                // .collection('rating')
                                                // .doc(currentStudentId)
                                                // .set({
                                                //   'rate' : rating
                                                // });

                                                firestore
                                                .collection('feedback')
                                                .doc(feedbackId)
                                                .collection('questions')
                                                .doc(feedbackQueMapList[index]['id'])
                                                .update({
                                                  'rating.'+currentStudentId : rating
                                                  
                                                });
                                                // .collection('rating')
                                                // .doc(currentStudentId)
                                                // .set({
                                                //   'rate' : rating
                                                // });

                                                firestore
                                                .collection('faculty')
                                                .doc(currentFacultyId)
                                                .collection('feedback')
                                                .doc(feedbackId)
                                                .collection('questions')
                                                .doc(feedbackQueMapList[index]['id'])
                                                .update({
                                                  'rating.'+currentStudentId : rating
                                                  
                                                });
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
                        );
                      }
                    }
                    return Container();
                  },
                ),
                 ElevatedButton(
              onPressed: () {
                 print(currentStudentId);
                // setState(() {
                firestore
                .collection('Academic Year')
                .doc(currentAcademicYearId)
                .collection('Department')
                .doc(currentDepartmentId)
                .collection('Division')
                .doc(currentDivisionId)
                .collection('feedback')
                .doc(feedbackId)
                .update({
                 
                  'submitted.' + currentStudentId : true
                });
                // });
                Navigator.pushNamed(context, studentScreenRoute);
              } ,
              child: Text('Submit'))
            ],
          ),
           
        ),
      ),
    );
  }
}