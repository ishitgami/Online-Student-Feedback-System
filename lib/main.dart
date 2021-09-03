import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:osfs1/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OSFS());
}

class OSFS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routerr.generateRoute,
      initialRoute: loginScreenRoute,
    );
  }
}
