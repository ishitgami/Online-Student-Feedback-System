import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class GetAcademicYearData {
  var academicYearMap = Map();
  final List<dynamic> academicYearList = [].toList();
  Future<Map> getAcademicYear() async {
    try {
      await firestore
          .collection('Academic Year')
          .get()
          .then((QuerySnapshot<Object> value) => {
                value.docs.forEach((DocumentSnapshot docs) {
                  if (docs.exists) {
                    academicYearMap[docs.id] = '${docs['Year']}';
                    academicYearList.add(docs['Year']);
                  }
                }),
              });
    } catch (e) {
      print(e);
    }
    return academicYearMap;
  }
}