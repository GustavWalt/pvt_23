import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/group_id_provider.dart';
import '../../widgets/navigation_bar_widget.dart';

const List<String> genres = <String>[
  'Action',
  'Adventure',
  'Comedy',
  'Drama',
  'Fantasy',
  'Horror',
  'Musicals',
  'Mystery',
  'Romance',
  'Science fiction',
  'Sports',
  'Thriller',
  'Western',
];
const List<String> level = <String>["Beginner", "Intermediate", "Expert"];
const List<String> size = <String>[
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
];

class CreateGroupPageEdit extends StatefulWidget {
  Stream<QuerySnapshot<Map<String, dynamic>>>? selectedGroup;
  CreateGroupPageEdit({super.key, this.selectedGroup});

  @override
  State<CreateGroupPageEdit> createState() => _CreateGroupPageEditState();
}

class _CreateGroupPageEditState extends State<CreateGroupPageEdit> {
  final db = FirebaseFirestore.instance;
  List _groupInfo = [];

  String sizeValue = "";
  String genreValue = "";
  String levelValue = "";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final groupIdProvider = Provider.of<GroupIdProvider>(context);
    String currentGroupId = groupIdProvider.fetchCurrentGroupId;
    return StreamBuilder<QuerySnapshot>(
        stream: widget.selectedGroup,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          snapshot.data!.docs.forEach((element) {
            _groupInfo.add(element.data());
          });
          return Scaffold(
            bottomNavigationBar: const MenuWidget(),
            backgroundColor: Color.fromARGB(255, 35, 33, 26),
            appBar: AppBar(
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        context.go("/profile_page");
                      },
                      child: Icon(Icons.account_circle),
                    ))
              ],
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.go("/group_page");
                    },
                  );
                },
              ),
              title: const Text('Edit group'),
              backgroundColor: Colors.black,
              centerTitle: true,
            ),
            body: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 600,
                        color: Color.fromARGB(255, 147, 48, 48),
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Color.fromARGB(255, 44, 44, 44),
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage:
                                      AssetImage("assets/images/no-image.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(100, 7, 100, 7),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: _groupInfo[0]['name'],
                        fillColor: const Color.fromARGB(255, 209, 217, 223)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(100, 7, 100, 7),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: _groupInfo[0]['description'],
                        fillColor: const Color.fromARGB(255, 209, 217, 223)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 7, 100, 7),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: _groupInfo[0]['size'],
                        fillColor: const Color.fromARGB(255, 209, 217, 223)),
                    onChanged: (String? value) {
                      setState(() {
                        sizeValue = value!;
                      });
                    },
                    items: size.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 7, 100, 7),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: _groupInfo[0]['genre'],
                        fillColor: const Color.fromARGB(255, 209, 217, 223)),
                    onChanged: (String? value) {
                      setState(() {
                        genreValue = value!;
                      });
                    },
                    items: genres.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 7, 100, 7),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: _groupInfo[0]['level'],
                        fillColor: const Color.fromARGB(255, 209, 217, 223)),
                    onChanged: (String? value) {
                      setState(() {
                        levelValue = value!;
                      });
                    },
                    items: level.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(30),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(140, 10, 140, 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromRadius(10),
                            backgroundColor:
                                const Color.fromARGB(255, 147, 48, 48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.all(20),
                            side: const BorderSide(
                                color: Colors.black, width: 3)),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Update",
                                  style: TextStyle(fontSize: 17)),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final User? currentUser = auth.currentUser;
                          final uid = currentUser!.uid;
                          int members = _groupInfo[0]['members'];
                          String membersString = members.toString();

                          final userData = <String, dynamic>{"uid": uid};
                          print(genreValue);
                          print(levelValue);
                          print(sizeValue);

                          if (sizeValue != "" &&
                              int.parse(sizeValue) < members) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Error"),
                                  content: Text(
                                      "There are already more members ($membersString"
                                      ") than the group size you entered, please change the size!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          } else {
                            if (_nameController.text == "") {
                              _nameController.text = _groupInfo[0]['name'];
                            }
                            if (_descriptionController.text == "") {
                              _descriptionController.text =
                                  _groupInfo[0]['description'];
                            }
                            if (sizeValue == "") {
                              sizeValue = _groupInfo[0]['size'];
                            }
                            if (genreValue == "") {
                              genreValue = _groupInfo[0]['genre'];
                            }
                            if (levelValue == "") {
                              levelValue = _groupInfo[0]['level'];
                            }
                            await db
                                .collection("groups")
                                .doc(currentGroupId)
                                .update({
                              "name": _nameController.text,
                              "description": _descriptionController.text,
                              "size": sizeValue,
                              "genre": genreValue,
                              "level": levelValue,
                            });
                            context.go('/group_page');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Success!"),
                              ),
                            );
                          }
                        }))
              ],
            ),
          );
        });
  }
}
