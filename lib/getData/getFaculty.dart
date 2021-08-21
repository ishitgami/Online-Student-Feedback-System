import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class GetFacultyData {
  var facultyMap = Map();
  Future getfaculty() async {
    try {
      await firestore
          .collection('faculty')
          .get()
          .then((QuerySnapshot<Object> value) => {
                value.docs.forEach((DocumentSnapshot docs) {
                  if (docs.exists) {
                    facultyMap[docs.id] = '${docs['First Name']}';
                  }
                })
              });
    } catch (e) {
      print(e);
    }
    return facultyMap;
  }
}
