import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class GetFeedbackQueByDivision {
  var queMap = <Map>[];

  GetFeedbackQueByDivision({
    this.currentAcademicYearId,
    this.currentDepartmentId,
    this.currentDivisionId,
    this.currentFeedbackId
    });

  final currentAcademicYearId;
  final currentDepartmentId;
  final currentDivisionId;
  final currentFeedbackId;

  Future getFeedbackQueByDivisionData() async{
    try {
      await firestore
          .collection('Academic Year')
          .doc(currentAcademicYearId)
          .collection('Department')
          .doc(currentDepartmentId)
          .collection('Division')
          .doc(currentDivisionId)
          .collection('feedback')
          .doc(currentFeedbackId)
          .collection('questions')
          .get()
          .then((value) => {
            value.docs.forEach((element) {
              print('element-->$element');
              if(element.exists) {
                queMap.add({
                    'id'  : '${element.id}',
                    'question' : '${element['que']}',
                });
              }
            })
          });
    } catch (e) {
    }
         return queMap;   
    }
}