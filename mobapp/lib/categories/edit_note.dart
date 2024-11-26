import 'package:flutter/material.dart';
import 'package:mobapp/components/textformfieldAdd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobapp/firebase_integration.dart';

import 'view_notes.dart';

class EditNote extends StatefulWidget {
  final String catID;
  final String noteID; // Document ID within 'notes' sub-collection
  final String oldNote; // Current note content

  const EditNote({
    super.key,
    required this.oldNote,
    required this.noteID,
    required this.catID,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();

  // Function to edit the note in the Firestore sub-collection

  @override
  void initState() {
    super.initState();
    // Pre-fill the TextEditingController with the old note content
    note.text = widget.oldNote;
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Edit Note',
          style: TextStyle(color: Colors.white),
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
                    return 'Cannot be empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.blue,
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        await editNote(widget.catID, widget.noteID,
                            note.text); // Call editNote to update Firestore
                        // Navigate back
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewPage(catID: widget.catID)),
                        );
                      } else {
                        print('Error in fields');
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
