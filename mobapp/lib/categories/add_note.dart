import 'package:flutter/material.dart';
import 'package:mobapp/categories/view_notes.dart';
import 'package:mobapp/components/textformfieldAdd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobapp/firebase_integration.dart';

class AddNote extends StatefulWidget {
  final String catNoteID;
  const AddNote({super.key, required this.catNoteID});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  CollectionReference? notes;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    note.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notes = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.catNoteID)
        .collection('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.blue, // Set the entire AppBar background color to blue
        title: const Text(
          'Add Note',
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
                  myController: note,
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
                        addNote(note.text, widget.catNoteID);
                        print('mazbooot');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewPage(catID: widget.catNoteID)),
                        );
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
