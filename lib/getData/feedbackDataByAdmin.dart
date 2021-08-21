import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FeedbackDataByAdmin {
  final List<dynamic> feedbackList = [].toList();

  Future<List> feedbackDataByAdmin() async {
    try {
      await firestore
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