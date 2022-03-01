import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AdminFirebaseQuery {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  //get Current User UId
  Future<String> getCurrentUserUid() async {
    var user = _auth.currentUser;
    return user.uid;
  }

  //get User-Data By ID
  Future getDocumentById() {
    var data = _db.collection('Users').where('role',isEqualTo: 'Admin').get();
    print(data);
    return data;
  }

  //get User-Data by OrgCode
  Future<QuerySnapshot> getDocumentByorg(String orgCode) {
    return _db
        .collection('Users')
        .where('role', isEqualTo: 'Admin')
        .where('orgCode', isEqualTo: orgCode)
        .get();
  }

  //Get OrgCode By Id
  Future<String> getOrgCode(userUid) async {
    String orgCode;
    await _db.collection('Users').doc(userUid).get().then((value) => {
          orgCode = value['orgCode'],
        });
    return orgCode;
  }

  //Add Academic Year
  addAcYear(userUid, element) {
     _db.collection('Users').doc(userUid).update({
      'AcYear': FieldValue.arrayUnion([element]),
    });
  }

  //get Faculty-Total By OrgCode
  getFacultyTotal(orgCode) async {
  var facultyTotal;
   await _db
     .collection('Users')
     .where('role', isEqualTo: 'faculty')
     .where('orgCode',isEqualTo: orgCode)
     .get().then((value){
      facultyTotal =  value.size;
     });
     return facultyTotal;
  }


}
