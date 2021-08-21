import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class GetDivisionData {
  var divisionMap = Map();

  GetDivisionData({this.currentAcademicYearId,this.currentDepartmentId});
  final currentAcademicYearId;
  final currentDepartmentId;
  List<dynamic> divisionList;
  Future getDivisiondata() async{
    try {
      await firestore
          .collection('Academic Year')
          .doc(currentAcademicYearId)
          .collection('Department')
          .doc(currentDepartmentId)
          .collection('Division')
          .get()
          .then((value) => {
            value.docs.forEach((element) {
              if(element.exists) {
                divisionMap[element.id] = '${element['name']}';
              }
            })
          });
    } catch (e) {
    }
         return divisionMap;   
    }
}