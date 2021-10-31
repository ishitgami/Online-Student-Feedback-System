import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'auth/login.dart';
import 'auth/registrationScreen.dart';
import 'admin/index.dart';
import 'admin/faculty.dart';
import 'admin/AcademicYear.dart';
import 'admin/student.dart';
import 'admin/Department.dart';
import 'admin/Division.dart';
import 'admin/subject.dart';
import 'admin/feedbackRestrictions.dart';
import 'admin/feedbackQue.dart';
import 'admin/report.dart';
import 'faculty/FacultyDashbord.dart';
import 'faculty/FacultyFeedbackclass.dart';
import 'student/index.dart';
import 'student/feedbackScreen.dart';


//SplashScreen
const String splashScreenRoute = '/SplashScreen';

//authentication
const String loginScreenRoute = '/';
const String registrationScreenRoute = '/RegistrationScreen';

//Admin
const String AdminScreenRoute = '/AdminScreen';
const String studentInAdminScreenRoute = '/StudentInAdminScreen';
const String facultyInAdminScreenRoute = '/FacultyInAdminScreen';
const String acadamicYearScreenRoute = '/AcadamicYearScreen';
const String departmentScreenRoute = '/DepartmentScreen';
const String divisionScreenRoute = '/DivisionScreen';
const String subjectScreenRoute = '/SubjectScreen';
const String restrictionsScreenRoute = '/FeedbackRestrictionsScreen';
const String questionScreenRoute = '/FeedbackQueScreen';
const String reportScreenRoute = '/ReportScreen';

//Faculty
const String FacultyDashbordScreenRoute = '/facultyDashbordScreen';
const String FacultyFclassScreenRoute = '/facultyFclassScreen';

//Student
const String studentScreenRoute = '/StudentScreen';
const String feedbackScreenRoute = '/FeedbackScreen';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen1());

      case loginScreenRoute:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case registrationScreenRoute:
        return MaterialPageRoute(builder: (context) => RegistrationScreen());

      case AdminScreenRoute:
        return MaterialPageRoute(builder: (context) => AdminScreen());

      case FacultyFclassScreenRoute:
        return MaterialPageRoute(builder: (context) => FacultyFclassScreen());

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

      case FacultyDashbordScreenRoute:
        return MaterialPageRoute(builder: (context) =>FacultyDashbordScreen());

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
