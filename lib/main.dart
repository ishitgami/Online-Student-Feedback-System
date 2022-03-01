import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:osfs1/presentation/router/route.dart';
import 'package:provider/provider.dart';
import 'data/model/Authentication.dart';
import 'data/model/AddUserDataFirebase.dart';
import 'data/model/AdminProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Authentication>(
          create: (_) => Authentication(),
        ),
        ChangeNotifierProvider<AddUserDataFirebase>(
          create: (_) => AddUserDataFirebase(),
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (_) => AdminProvider(),
        ),
      ],
      child: OSFS(),
    ),
  );
}

class OSFS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: splashScreenRoute,
    );
  }
}
