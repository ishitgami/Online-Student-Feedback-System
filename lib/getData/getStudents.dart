import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class GetStudentData {
  var studentMap = <Map>[];

  GetStudentData({this.currentAcademicYearId,this.currentDepartmentId,this.currentDivisionId});
  final currentAcademicYearId;
  final currentDepartmentId;
  final currentDivisionId;
  Future getStudentdata() async{
    try {
      await firestore 
          .collection('Academic Year')
          .doc(currentAcademicYearId)
          .collection('Department')
          .doc(currentDepartmentId)
          .collection('Division')
          .doc(currentDivisionId)
          .collection('Students')
          .orderBy('Enrollment No')
          .get()
          .then((value) => {
            value.docs.forEach((element) {
              if(element.exists) {
                studentMap.add({
                    'id'  : '${element.id}',
                    'FirstName' : '${element['First Name']}',
                    'MiddleName' : '${element['Middle Name']}',
                    'LastName'  : '${element['Last Name']}',
                    'Email' : '${element['Email']}',
                    'Enrolment' : '${element['Enrollment No']}',
                });
              }
            })
          });
    } catch (e) {
    }
         return studentMap;   
    }
}