import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osfs1/auth/authErrorHendling.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Authentication extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  //Authentication While User Login
  loginAuthentication({
    String email,
    String password,
  }) async {
    String userUId;
    String errorMessage;
    var newUser;
    try {
      newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      userUId = newUser.user.uid;
    } catch (error) {
      print(error.code);
      errorMessage = ErrorHangling().throwErrorMesg(errorCode: error.code);
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return userUId.toString();
  }

  //Authintication While User Registration
  registrationAuthentication({
    String emailAddress,
    String password,
  }) async {
    String errorMessage;
    String userUId;
    var newUser;
    try {
      newUser = await _auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      userUId = newUser.user.uid;
    } catch (error) {
      errorMessage = ErrorHangling().throwErrorMesg(errorCode: error.code);
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return userUId.toString();
  }

  //Check User Enter Organation Code Is Valid Or Not
  isValidOrgCode(orgId) async {
    bool validOrgId;
    await firestore
        .collection('Users')
        .where('role', isEqualTo: 'Admin')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                if (orgId == element['orgCode']) {
                  validOrgId = true;
                }
              })
            });
    return validOrgId;
  }
}
