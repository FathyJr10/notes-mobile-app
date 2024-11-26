// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mobapp/auth/auth_functions.dart';
import 'package:mobapp/components/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formState,
          child: ListView(
            children: [
              Column(
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
                    'Sign up',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                  const Text(
                    'Sign up to continue using the app',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    'Username',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    height: 5,
                  ),
                  MyTextfieldForm(
                    hintText: 'enter your Username',
                    myController: username,
                    validator: (val) {
                      if (val == "") {
                        return "error username is wrong";
                      }
                    },
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
                        return "error email is wrong";
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
                        return "error password is wrong";
                      }
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                ],
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
                    signUp(context, email.text, password.text);
                  } else {
                    print('error in fields');
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 15,
              ),
              Container(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("signIn");
                },
                child: Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(text: "already have an account ? "),
                    TextSpan(
                        text: "Login",
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
      ),
    );
  }
}
