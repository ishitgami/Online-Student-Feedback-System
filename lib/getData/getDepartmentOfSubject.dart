import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class GetDepartmentOfSubject {
  var departmentMap = Map();
  Future getDepartment() async {
    try {
      await firestore
          .collection('Subjects')
          .get()
          .then((QuerySnapshot<Object> value) => {
                value.docs.forEach((DocumentSnapshot docs) {
                  if (docs.exists) {
                    departmentMap[docs.id] = '${docs['name']}';
                  }
                }),
              });
    } catch (e) {
      print(e);
    }
    return departmentMap;
  }
}
