import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobapp/components/textformfieldAdd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobapp/firebase_integration.dart';

class AddCat extends StatefulWidget {
  const AddCat({super.key});

  @override
  State<AddCat> createState() => _AddCatState();
}

class _AddCatState extends State<AddCat> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.blue, // Set the entire AppBar background color to blue
        title: const Text(
          'Add category',
          style: TextStyle(
              color: Colors
                  .white), // Set text color to contrast with blue background
        ),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: MyTextfieldFormAdd(
                  hintText: 'Enter name',
                  myController: name,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'cant be empty';
                    }
                  }),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.blue,
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        addCategory(
                          name.text,
                          categories,
                          userID,
                        );
                        print('mazbooot');
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'homepage', (route) => false);
                      } else {
                        print('error in fields');
                      }
                    },
                    child: Text(
                      'add',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
