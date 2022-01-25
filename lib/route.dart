import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'auth/login.dart';
import 'auth/StudentRegistrationScreen.dart';
import 'auth/navigateToReg.dart';
import 'auth/organizationReg.dart';
import 'auth/facultyRegistration.dart';
import 'admin/AdminDashbord.dart';
import 'admin/faculty.dart';
import 'admin/AcademicYear.dart';
import 'admin/student.dart';
import 'admin/Department.dart';
import 'admin/subject.dart';
import 'admin/feedbackRestrictions.dart';
import 'admin/feedbackQue.dart';
import 'admin/report.dart';
import 'faculty/FacultyDashbord.dart';
import 'faculty/allFClassScreen.dart';
import 'faculty/FeedbackClassScreen.dart';
import 'student/index.dart';
import 'student/feedbackScreen.dart';


//SplashScreen
const String splashScreenRoute = '/';

//authentication
const String loginScreenRoute = '/loginScreen';
const String navToDiffRegistrationRoute = '/navToDiffRegistrationRouteScreen';
const String studentRegScreenRoute = '/RegistrationScreen';
const String orgRegistrationRoute = '/orgRegistrationRouteScreen';
const String facultyRegRoute = '/facultyRegRouteScreen';


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
const String FacultyFeedbackClassScreenRoute = 'facultyFeedbackClassScreen';

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

      case navToDiffRegistrationRoute:
        return MaterialPageRoute(builder: (context) => NavigateToDiffReg());

      case studentRegScreenRoute:
        return MaterialPageRoute(builder: (context) => StudentRegistrationScreen());

      case facultyRegRoute:
        return MaterialPageRoute(builder: (context) => FacultyRegScreen());

      case orgRegistrationRoute:
        return MaterialPageRoute(builder: (context) => OrgRegistrationScreen());

   

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

      case FacultyFeedbackClassScreenRoute:
        return MaterialPageRoute(builder: (context) =>FeedbackClassScreen());

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
