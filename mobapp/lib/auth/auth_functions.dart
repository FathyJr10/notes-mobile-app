import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> signUp(
    BuildContext context, String emailAddress, String password) async {
  try {
    print('clicked ya man');

    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    // ignore: use_build_context_synchronously
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    Navigator.of(context).pushReplacementNamed("signIn");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'account already exists.',
        btnOkOnPress: () {},
      ).show();
    } else if (e.code == 'weak-password') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'password is very weak.',
        btnOkOnPress: () {},
      ).show();
    }
  } catch (e) {
    print(e);
  }
}

Future<void> signOut(BuildContext context) async {
  //google sign out
  GoogleSignIn googleSignIn = GoogleSignIn();
  googleSignIn.disconnect();
  await FirebaseAuth.instance.signOut();
  print('atlaa3 bara ya kalb');
  Navigator.of(context).pushNamedAndRemoveUntil("signIn", (route) => false);
}

Future<void> checkAuth() async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('+++++++++++++++++User is currently signed out!');
    } else {
      print('+++++++++++++++++User is signed in!');
    }
  });
}

Future<void> logIn(
  BuildContext context,
  String emailAddress,
  String password,
) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    if (credential.user!.emailVerified) {
      Navigator.of(context).pushReplacementNamed("homepage");
    } else {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Imp',
        desc: 'Please Verify Your e-mail',
        btnOkOnPress: () {},
      ).show();
    }
  } on FirebaseAuthException catch (e) {
    print(e.code);

    if (e.code == 'invalid-credential') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Invalid data for user',
        desc: 'No user found for that email address or password is wrong.',
        btnOkOnPress: () {},
      ).show();
    }
  } catch (e) {
    print(e);
  }
}

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return; //hykhorog bara el function
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed("homepage");
  } catch (e) {
    print(" ${e}");
  }
}

Future<void> forgetPass(String emailAddress, BuildContext context) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailAddress); //ma3dtsh bt-check elauth khalas
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      //animType: AnimType.,
      title: 'Check ur inbox',
      desc: 'an email is sent to your email if the email exists.',
      btnOkOnPress: () {},
    ).show();
  } catch (e) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Invalid email',
      desc: 'email is badly formatted enter a valid email.',
      btnOkOnPress: () {},
    ).show();
  }
}
