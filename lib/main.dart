import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:osfs1/route.dart';
import 'package:provider/provider.dart';
import 'Model/Authentication-model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
     MultiProvider(
        providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_)=>UserProvider(),
        )
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

