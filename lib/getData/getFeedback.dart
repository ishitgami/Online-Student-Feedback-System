import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FeedbackData {
  final List<dynamic> feedbackList = [].toList();
  Future getFeedback() async {
    try {
      await firestore
          .collection('feedback')
          .get()
          .then((QuerySnapshot<Object> value) => {
                value.docs.forEach((DocumentSnapshot docs) {
                  if (docs.exists) {
                    feedbackList.add(
                      docs['ID']
                      );
                  }
                }),
              });
    } catch (e) {
      print(e);
    }
    return feedbackList;
  }
}