import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobapp/categories/edit_note.dart';

String userID = FirebaseAuth.instance.currentUser!.uid;

addCategory(String name, categories, String id) async {
  try {
    DocumentReference response =
        await categories.add({'name': name, 'currentUserID': id});
  } catch (e) {
    print("Error: ${e}");
  }
}

deleteCat(String id) async {
  await FirebaseFirestore.instance.collection('categories').doc(id).delete();
}

editCat(dynamic categories, dynamic docID, dynamic name) async {
  try {
    // Await the result of adding a category
    var response = await categories.doc(docID).update({'name': name});
  } catch (e) {
    print("Error: ${e}");
  }
}

addNote(String note, String noteID) async {
  try {
    CollectionReference noteCollection = FirebaseFirestore.instance
        .collection('categories')
        .doc(noteID)
        .collection('notes');
    DocumentReference response = await noteCollection.add({'note': note});
  } catch (e) {
    print("Error: ${e}");
  }
}

Future<void> editNote(String? catID, String? noteID, dynamic note) async {
  try {
    // Reference to the specific document in the 'notes' sub-collection
    DocumentReference noteDoc = FirebaseFirestore.instance
        .collection('categories')
        .doc(catID)
        .collection('notes')
        .doc(noteID);

    // Update the 'note' field with the new content
    await noteDoc.update({"note": note});
  } catch (e) {
    print("Error updating note: $e");
  }
}

deleteNote(String catID, String noteID) async {
  try {
    // Reference to the specific document in the 'notes' sub-collection
    DocumentReference noteDoc = FirebaseFirestore.instance
        .collection('categories')
        .doc(catID)
        .collection('notes')
        .doc(noteID);

    // Update the 'note' field with the new content
    await noteDoc.delete();
  } catch (e) {
    print("Error deleting note: $e");
  }
}
