import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_marketplace/screens/departments.dart';
import 'package:student_marketplace/screens/signup.dart';

import 'firebase_options.dart';
import 'models/UserModel.dart';
import 'models/firebaseHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    UserModel? userModelFromHelper =
        await FirebaseHelper.getUserModel(currentUser.uid);
    if (userModelFromHelper != null) {
      runApp(MyAppLoggedIn(
          firebaseUser: currentUser, userModel: userModelFromHelper));
    }
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SignUpScreen(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final User firebaseUser;
  final UserModel userModel;
  const MyAppLoggedIn(
      {super.key, required this.firebaseUser, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DepartmentScreen(firebaseUser: firebaseUser, userModel: userModel),
    );
    ;
  }
}
