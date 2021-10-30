import 'package:flutter/material.dart';

class FaculltyFClassScreen extends StatefulWidget {
  FaculltyFClassScreen({this.feedbackClassId});
  final String feedbackClassId;

  @override
  _FaculltyFClassScreenState createState() => _FaculltyFClassScreenState(feedbackClassId: feedbackClassId);
}

class _FaculltyFClassScreenState extends State<FaculltyFClassScreen> {
  _FaculltyFClassScreenState({this.feedbackClassId});
  final String feedbackClassId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child : Text(feedbackClassId),
        ),
      ),
    );
  }
}