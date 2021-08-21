import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class GetDepartmentData {
  var departmentMap = Map();
  GetDepartmentData({this.currentAcademicYearId});
  final currentAcademicYearId;
  List<dynamic> departmentList = [];

  Future<Map> getDepartment() async {
    try {
     await firestore
          .collection('Academic Year')
          .doc(currentAcademicYearId)
          .collection('Department')
          .get()
          .then((value) => {
            value.docs.forEach((DocumentSnapshot docs) {
              if (docs.exists) {
                  departmentMap[docs.id]= '${docs['name']}';
                  departmentList.add(docs['name']);
              }
            }),
          });
         
    } catch (e) {
      print(e);
    }
     return departmentMap;
  }
}