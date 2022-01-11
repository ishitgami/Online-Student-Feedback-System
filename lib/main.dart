import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:osfs1/route.dart';
import 'package:provider/provider.dart';
import 'Model/Authentication.dart';
import 'Model/AddUserDataFirebase.dart';
import 'Model/admin-model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
     MultiProvider(
        providers: [
        ChangeNotifierProvider<Authentication>(
          create: (_)=>Authentication(),
        ),
        ChangeNotifierProvider<AddUserDataFirebase>(
          create: (_)=>AddUserDataFirebase(),
        ),
        ChangeNotifierProvider<AdminModel>(
          create: (_)=>AdminModel(),
        ),
      ],
    child : OSFS())
    );
}

class OSFS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      initialRoute: splashScreenRoute,
    );
  }
}