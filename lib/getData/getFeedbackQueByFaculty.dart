import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class GetQuewithRatingForFaculty {
  var queMap = <Map>[];

  GetQuewithRatingForFaculty({
      this.currentFacultyId,
      this.feedbackId
    });

    final currentFacultyId;
    final feedbackId;

  Future getQuewithRatingForFacultyData() async{
    try {
      await firestore
          .collection('faculty')
          .doc(currentFacultyId)
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