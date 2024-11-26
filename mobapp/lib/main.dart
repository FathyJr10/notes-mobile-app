import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobapp/auth/auth_functions.dart';
import 'package:mobapp/auth/login.dart';
import 'package:mobapp/auth/signup.dart';
import 'package:mobapp/categories/add_cat.dart';
//import 'package:mobapp/filter.dart';
import 'package:mobapp/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: //FilterFirestore(),
          (FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.emailVerified)
              ? HomePage()
              : Login(),
      routes: {
        "signUp": (context) => SignUp(),
        "signIn": (context) => Login(),
        "homepage": (context) => HomePage(),
        "addCat": (context) => AddCat(),
      },
    );
  }
}
