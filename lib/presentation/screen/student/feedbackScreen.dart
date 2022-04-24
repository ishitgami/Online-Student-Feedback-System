import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:provider/provider.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen(this.feedbackId,this.studentId);
  var feedbackId;
  var studentId;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState(feedbackId,studentId);
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  _FeedbackScreenState(this.feedbackClassId,this.studentId);
  String feedbackClassId;
  String studentId;
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
      appBar: AppBar(title: Text('FeedBack Form'),),
      body: SafeArea(
        child: 
        feedbackClassMapList == null ? Center(child: CircularProgressIndicator()) :
        Container(
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
                                    print(feedbackClassMapList[index]['id']);
                                    collegedata.ratingUpadate(feedbackClassId,feedbackClassMapList[index]['id'],rating,studentId);
                                    // print(rating);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back')),
                      SizedBox(
                        width: 20,
                      ),
                  ElevatedButton(
                      onPressed: () async {
                        collegedata.onFeedbackSubmit(feedbackClassId,studentId);
                        print(currentStudentId);
                        Navigator.pop(context);
                      },
                      child: Text('Submit')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
