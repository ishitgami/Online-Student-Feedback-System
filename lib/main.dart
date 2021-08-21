  import 'package:flutter/material.dart';
  import 'package:osfs1/admin/feedbackRestrictions.dart';
  import 'package:osfs1/auth/registrationScreen.dart';
  import 'auth/login.dart';
  import 'auth/registrationScreen.dart';
  import 'admin/index.dart';
  import 'admin/faculty.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'student/index.dart';
  import 'admin/AcademicYear.dart';
  import 'admin/student.dart';
  import 'admin/Department.dart';
  import 'admin/classes.dart';
  import 'admin/subject.dart';
  import 'admin/feedbackRestrictions.dart';
  import 'admin/feedbackQue.dart';
  import 'faculty/index.dart';
  import 'student/feedbackScreen.dart';
  import 'admin/report.dart';

  void main() async{  
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(OSFS());
    } 

  class OSFS extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        initialRoute: LoginScreen.id,
        // onGenerateRoute: ,
        routes: {
          LoginScreen.id : (context) => LoginScreen(),
          RegistrationScreen.id : (context) => RegistrationScreen(),
          AdminScreen.id : (context) => AdminScreen(),
          StudentScreen.id : (context) => StudentScreen(),
          StudentInAdminScreen.id : (context) => StudentInAdminScreen(),
          FacultyInAdmin.id : (context) => FacultyInAdmin(),
          AcadamicYear.id : (context) => AcadamicYear(),
          Department.id : (context) => Department(),
          ClassScreen.id : (context) => ClassScreen(),
          Subject.id : (context) => Subject(),
          FeedbackRestrictionsScreen.id : (context) => FeedbackRestrictionsScreen(),
          FeedbackQue.id : (context) => FeedbackQue(),
          FacultyScreen.id : (context) => FacultyScreen(),
          FeedbackScreen.id : (context) => FeedbackScreen(),
          ReportScreen.id : (context) => ReportScreen(),

        },
      );
    }
  }