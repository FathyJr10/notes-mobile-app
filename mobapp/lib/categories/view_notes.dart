import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobapp/auth/auth_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobapp/categories/add_note.dart';
import 'package:mobapp/categories/edit_note.dart';
import 'package:mobapp/firebase_integration.dart';

class ViewPage extends StatefulWidget {
  final String catID;

  const ViewPage({super.key, required this.catID});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  List<QueryDocumentSnapshot> data = [];

  bool isLoading = true; //initialization

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.catID)
        .collection('notes')
        .get(); //ana a2dar a3ml collection =====> document ======> collection (nested collection)
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNote(
                    catNoteID: widget.catID,
                  )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor:
            Colors.blue, // Set the entire AppBar background color to blue
        title: const Text(
          'View',
          style: TextStyle(
              color: Colors
                  .white), // Set text color to contrast with blue background
        ),
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: const Icon(Icons.exit_to_app),
            color: Colors
                .white, // Optional: set the icon color to white for contrast
          ),
        ],
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
          child: isLoading == true
              ? Center(
                  child: LoadingAnimationWidget.progressiveDots(
                  color: Colors.blue,
                  size: 50,
                ))
              : Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 160),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditNote(
                                  catID: widget.catID,
                                  noteID: data[index].id,
                                  oldNote: data[index]['note'])));
                        },
                        onLongPress: () {
                          // deleteNote(widget.catID, data[index].id);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Confirmation',
                            desc: 'do you really want to delete this note ?',
                            btnCancelColor: Colors.red,
                            btnCancelText: 'yes',
                            btnCancelOnPress: () {
                              deleteNote(widget.catID, data[index].id);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewPage(catID: widget.catID)),
                              );
                            },
                            btnOkText: 'no',
                            btnOkColor: Colors.green,
                            btnOkOnPress: () {},
                          ).show();
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [Text("${data[index]['note']}")],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          onWillPop: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('homepage', (route) => false);
            return Future.value(false);
          }),
    );
  }
}
