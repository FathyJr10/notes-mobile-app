import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobapp/auth/auth_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobapp/categories/edit_cat.dart';
import 'package:mobapp/categories/view_notes.dart';
import 'package:mobapp/firebase_integration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> data = [];

  bool isLoading = true; //initialization

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('currentUserID',
            isEqualTo: FirebaseAuth.instance.currentUser!
                .uid) //best practice till now el fekra fe el await w el async
        .get();

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
            Navigator.of(context).pushNamed('addCat');
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
            'Home Page',
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
        body: isLoading == true
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
                            builder: (context) =>
                                ViewPage(catID: data[index].id)));
                      },
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Confirmation',
                          desc: 'choose an option',
                          btnCancelColor: Colors.green,
                          btnCancelText: 'update',
                          btnCancelOnPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditCat(
                                    docID: data[index].id,
                                    oldName: data[index]['name'])));
                          },
                          btnOkText: 'DELETE',
                          btnOkColor: Colors.red,
                          btnOkOnPress: () {
                            deleteCat(data[index].id);
                            print('deleted ya negm');
                            Navigator.of(context)
                                .pushReplacementNamed('homepage');
                          },
                        ).show();
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/folder.png',
                                height: 100,
                              ),
                              Text("${data[index]['name']}")
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
