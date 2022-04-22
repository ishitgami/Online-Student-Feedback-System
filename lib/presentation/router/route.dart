import 'package:flutter/material.dart';
import 'package:osfs1/presentation/screen/admin/AcademicYear.dart';
import 'package:osfs1/presentation/screen/admin/AdminDashbord.dart';
import 'package:osfs1/presentation/screen/admin/Department.dart';
import 'package:osfs1/presentation/screen/admin/faculty.dart';
import 'package:osfs1/presentation/screen/admin/feedbackQue.dart';
import 'package:osfs1/presentation/screen/admin/feedbackRestrictions.dart';
import 'package:osfs1/presentation/screen/admin/report.dart';
import 'package:osfs1/presentation/screen/admin/subject.dart';
import 'package:osfs1/presentation/screen/auth/StudentRegistrationScreen.dart';
import 'package:osfs1/presentation/screen/auth/facultyRegistration.dart';
import 'package:osfs1/presentation/screen/auth/login.dart';
import 'package:osfs1/presentation/screen/auth/navigateToReg.dart';
import 'package:osfs1/presentation/screen/auth/organizationReg.dart';
import 'package:osfs1/presentation/screen/faculty/FacultyDashbord.dart';
import 'package:osfs1/presentation/screen/faculty/FeedbackClassScreen.dart';
import 'package:osfs1/presentation/screen/faculty/allFClassScreen.dart';
import 'package:osfs1/presentation/screen/student/feedbackScreen.dart';
import 'package:osfs1/presentation/screen/student/studentDashboard.dart';
import 'package:osfs1/splashScreen.dart';

//SplashScreen
const String splashScreenRoute = '/';

//authentication
const String loginScreenRoute = '/loginScreen';
const String navToDiffRegistrationRoute = '/navToDiffRegistrationRouteScreen';
const String studentRegScreenRoute = '/RegistrationScreen';
const String orgRegistrationRoute = '/orgRegistrationRouteScreen';
const String facultyRegRoute = '/facultyRegRouteScreen';

//Admin
const String AdminDashbordRoute = '/AdminScreen';
const String facultyInAdminScreenRoute = '/FacultyInAdminScreen';
const String acadamicYearScreenRoute = '/AcadamicYearScreen';
const String departmentScreenRoute = '/DepartmentScreen';
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

      case AdminDashbordRoute:
        return MaterialPageRoute(builder: (context) => AdminScreen());

      case FacultyFclassScreenRoute:
        return MaterialPageRoute(builder: (context) => FacultyFclassScreen());

      case studentScreenRoute:
        return MaterialPageRoute(builder: (context) => StudentScreen());

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

      case reportScreenRoute:
        return MaterialPageRoute(builder: (context) => ReportScreen());

      case FacultyDashbordScreenRoute:
        return MaterialPageRoute(builder: (context) => FacultyDashbordScreen());

      case FacultyFeedbackClassScreenRoute:
        return MaterialPageRoute(builder: (context) => FeedbackClassScreen());

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
