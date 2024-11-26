// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:mobapp/auth/auth_functions.dart';
import 'package:mobapp/components/textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(70)),
                      child: Image.asset(
                        "assets/logo.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                  const Text(
                    'Login to continue using the app',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    height: 5,
                  ),
                  MyTextfieldForm(
                    hintText: 'enter your Email',
                    myController: email,
                    validator: (val) {
                      if (val == "") {
                        return "write a valid email";
                      }
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    height: 5,
                  ),
                  MyTextfieldForm(
                    hintText: 'enter your password',
                    myController: password,
                    validator: (val) {
                      if (val == "") {
                        return "write a valid password";
                      }
                    },
                  ),
                  Container(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      forgetPass(email.text, context);
                      //print('object');
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      child: const Text(
                        'Forget password ?',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              color: Colors.blue,
              onPressed: () {
                if (formState.currentState!.validate()) {
                  logIn(context, email.text, password.text);
                } else {
                  print('error in fields');
                }
              },
              child: Text(
                'login',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 15,
            ),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              color: Colors.blue,
              onPressed: () {
                signInWithGoogle(context); //byza msh 3aref leeh ???
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue with google',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Container(width: 10),
                  Image.asset(
                    'assets/google.png',
                    width: 20,
                  )
                ],
              ),
            ),
            Container(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signUp");
              },
              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: "Don't have an account ? "),
                  TextSpan(
                      text: "Register",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline))
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
