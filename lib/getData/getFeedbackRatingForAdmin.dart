import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class GetRatingForAdmin {
  var queMap = <Map>[];

  GetRatingForAdmin({
      this.feedbackId
    });

    final feedbackId;

  Future getRatingForAdminData() async{
    try {
      await firestore
          .collection('feedback')
          .doc(feedbackId)
          .collection('questions')
          .get()
          .then((value) => {
            value.docs.forEach((element) {
              if(element.exists) {
                queMap.add({
                    'id'  : '${element.id}',
                    'question' : '${element['que']}',
                    'rating' : element['rating']
                });
              }
            })
          });
    } catch (e) {
    }
         return queMap;   
    }
}