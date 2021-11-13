import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:osfs1/Model/Authentication-model.dart';
import 'package:osfs1/commanWidget/bottemWave.dart';
import 'package:osfs1/commanWidget/logoContainer.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../route.dart';

class StudentRegistrationScreen extends StatefulWidget {
  @override
  _StudentRegistrationScreenState createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  UserProvider userProvider;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _form = GlobalKey<FormState>(); //for storing form state.
  User user;

  //saving form after validation
  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
  }

  void addStudentToUsers(cUserId) {
    userProvider.addStudentData(
      // academicYear: currentAcademicYearValue,
      // department: currentDepartmentValue,
      email: emailAddress,
      enrollment: enrollmentNo,
      firstName: firstName,
      lastName: lastName,
      uId: cUserId,
    );
  }

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Form(
        key: _form,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BottomWave(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LogoHeading(),
                RegisterContainer(),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 10),
                          FirstNameTextField(),
                          SizedBox(height: 10),
                          LastNameTextField(),
                          SizedBox(height: 10),
                          EnrollmentNoTextField(),
                          SizedBox(height: 10),
                          EmailTextField(),
                          SizedBox(height: 10),
                          PasswordTextField(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10, left: 115, right: 115, bottom: 18),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(5),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  _saveForm();
                                  try {
                                    final newUser = await userProvider.registrationAuthentication(
                                        emailAddress: emailAddress,
                                        password: password);
                                    addStudentToUsers(newUser.toString());
                                    Navigator.pushNamed(
                                        context, loginScreenRoute);
                                  } catch (e) {
                                    return alertBox(context, e);
                                    // print(e);
                                  }
                                },
                                child: Text(
                                  'SignIn',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Alredy Register? '),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, loginScreenRoute);
                                  },
                                  child: Text('Login Page',style: TextStyle(color: Colors.blue),))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Future<void> alertBox(BuildContext context, e) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Alert"),
        content: Text(e.toString()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val.length < 6 ? 'Password too short.' : null,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
      ),
      onChanged: (text) {
        password = text;
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
      validator: (text) {
        if (!(text.contains('@')) && text.isEmpty) {
          return "Enter a valid email address!";
        }
        return null;
      },
      onChanged: (text) {
        emailAddress = text;
      },
    );
  }
}

class EnrollmentNoTextField extends StatelessWidget {
  const EnrollmentNoTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enrollment No.',
        prefixIcon: Icon(Icons.assignment_ind_outlined),
      ),
      validator: (text) {
        if ((text.length != 12)) {
          return "Enter valid Enrollment ";
        }
        return null;
      },
      onChanged: (text) {
        enrollmentNo = text;
      },
    );
  }
}

class LastNameTextField extends StatelessWidget {
  const LastNameTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last Name',
        prefixIcon: Icon(Icons.account_circle_outlined),
      ),
      onChanged: (text) {
        lastName = text;
      },
      validator: (text) {
        if (text.isEmpty) {
          return "Enter Last Name ";
        }
        return null;
      },
    );
  }
}

class FirstNameTextField extends StatelessWidget {
  const FirstNameTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'First Name',
        prefixIcon: Icon(Icons.account_circle_outlined),
      ),
      onChanged: (text) {
        firstName = text;
      },
      validator: (text) {
        if (text.isEmpty) {
          return "Enter First Name ";
        }
        return null;
      },
    );
  }
}

class RegisterContainer extends StatelessWidget {
  const RegisterContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(20, 10, 16, 5),
      child: Text(
        'Register',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
            color: Colors.blueAccent),
      ),
    );
  }
}


