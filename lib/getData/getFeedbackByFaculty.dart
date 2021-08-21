import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FeedbackDataByFaculty {
  final List<dynamic> feedbackList = [].toList();
    FeedbackDataByFaculty({this.currentFacultyId});

  final currentFacultyId;

  Future<List> getFeedbackByFaculty() async {
    try {
      await firestore
          .collection('faculty')
          .doc(currentFacultyId)
          .collection('feedback')
          .get()
          .then((QuerySnapshot<Object> value) => {
                value.docs.forEach((DocumentSnapshot docs) {
                  if (docs.exists) {
                    feedbackList.add(docs.id);
                  }
                }),
              });
    } catch (e) {
      print(e);
    }
    return feedbackList;
  }
}