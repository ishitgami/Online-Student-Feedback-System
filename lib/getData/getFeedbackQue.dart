import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FeedbackQueData {
 var feedbackQueMap= Map();
  final List<dynamic> feedbackQueList = [].toList();
  Future<Map> getFeedbackQue() async {
    try {
      await firestore
          .collection('Questions')
          .get()
          .then((QuerySnapshot<Object> value) => {
                value.docs.forEach((DocumentSnapshot docs) {
                  if (docs.exists) {
                     feedbackQueMap[docs.id] = '${docs['que']}';
                    feedbackQueList.add(docs.id);
                  }
                }),
              });
    } catch (e) {
      print(e);
    }
    return feedbackQueMap;
  }
}