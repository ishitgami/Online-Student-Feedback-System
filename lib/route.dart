import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth/login.dart';
import 'auth/registrationScreen.dart';
import 'admin/index.dart';
import 'admin/faculty.dart';
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

const String loginScreenRoute = '/';
const String registrationScreenRoute = '/RegistrationScreen';
const String AdminScreenRoute = '/AdminScreen';
const String facultyScreenRoute = '/facultyScreen';
const String studentScreenRoute = '/StudentScreen';
const String studentInAdminScreenRoute = '/StudentInAdminScreen';
const String facultyInAdminScreenRoute = '/FacultyInAdminScreen';
const String acadamicYearScreenRoute = '/AcadamicYearScreen';
const String departmentScreenRoute = '/DepartmentScreen';
const String divisionScreenRoute = '/DivisionScreen';
const String subjectScreenRoute = '/SubjectScreen';
const String restrictionsScreenRoute = '/FeedbackRestrictionsScreen';
const String questionScreenRoute = '/FeedbackQueScreen';
const String feedbackScreenRoute = '/FeedbackScreen';
const String reportScreenRoute = '/ReportScreen';

class Routerr {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreenRoute:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case registrationScreenRoute:
        return MaterialPageRoute(builder: (context) => RegistrationScreen());

      case AdminScreenRoute:
        return MaterialPageRoute(builder: (context) => AdminScreen());

      case facultyScreenRoute:
        return MaterialPageRoute(builder: (context) => FacultyScreen());

      case studentScreenRoute:
        return MaterialPageRoute(builder: (context) => StudentScreen());

      case studentInAdminScreenRoute:
        return MaterialPageRoute(builder: (context) => StudentInAdminScreen());

      case facultyInAdminScreenRoute:
        return MaterialPageRoute(builder: (context) => FacultyInAdmin());

      case acadamicYearScreenRoute:
        return MaterialPageRoute(builder: (context) => AcadamicYearScreen());

      case departmentScreenRoute:
        return MaterialPageRoute(builder: (context) => DepartmentScreen());

      case divisionScreenRoute:
        return MaterialPageRoute(builder: (context) => Divisioncreen());

      case subjectScreenRoute:
        return MaterialPageRoute(builder: (context) => SubjectScreen());

      case restrictionsScreenRoute:
        return MaterialPageRoute(builder: (context) => RestrictionsScreen());

      case questionScreenRoute:
        return MaterialPageRoute(builder: (context) => QuestionScreen());

      case feedbackScreenRoute:
        return MaterialPageRoute(builder: (context) => FeedbackScreen());

      case reportScreenRoute:
        return MaterialPageRoute(builder: (context) => ReportScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
