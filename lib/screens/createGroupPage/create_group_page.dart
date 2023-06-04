import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/navigation_bar_widget.dart';

const List<String> genres = <String>[
  "Genre:",
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
const List<String> level = <String>[
  "Discussion level:",
  "Beginner",
  "Intermediate",
  "Expert"
];
const List<String> size = <String>[
  "Size:",
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

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final db = FirebaseFirestore.instance;

  String sizeValue = size.first;
  String genreValue = genres.first;
  String levelValue = level.first;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Create group'),
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
                          backgroundColor: Color.fromARGB(255, 44, 44, 44),
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
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Name",
                  fillColor: Color.fromARGB(255, 209, 217, 223)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(100, 7, 100, 7),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Description",
                  fillColor: Color.fromARGB(255, 209, 217, 223)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 7, 100, 7),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Size",
                  fillColor: Color.fromARGB(255, 209, 217, 223)),
              onChanged: (String? value) {
                setState(() {
                  sizeValue = value!;
                });
              },
              items: size.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 7, 100, 7),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Genre",
                  fillColor: Color.fromARGB(255, 209, 217, 223)),
              onChanged: (String? value) {
                setState(() {
                  genreValue = value!;
                });
              },
              items: genres.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 7, 100, 7),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Discussion level",
                  fillColor: Color.fromARGB(255, 209, 217, 223)),
              onChanged: (String? value) {
                setState(() {
                  levelValue = value!;
                });
              },
              items: level.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(30),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(125, 10, 125, 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromRadius(10),
                      backgroundColor: const Color.fromARGB(255, 147, 48, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.all(20),
                      side: const BorderSide(color: Colors.black, width: 3)),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.add, size: 16),
                        ),
                        TextSpan(
                            text: "Create group",
                            style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final User? currentUser = auth.currentUser;
                    final uid = currentUser!.uid;

                    final userData = <String, dynamic>{"uid": uid};

                    if (_nameController.text == "" ||
                        _descriptionController.text == "" ||
                        sizeValue == size.first ||
                        genreValue == genres.first ||
                        levelValue == level.first) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text("Please fill in all fields"),
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
                      final groupData = <String, dynamic>{
                        "description": _descriptionController.text,
                        "genre": genreValue,
                        "level": levelValue,
                        "name": _nameController.text,
                        "size": sizeValue,
                        "admin": uid,
                        "posts": [],
                        "members": 1,
                        "memberId": {uid},
                      };
                      DocumentReference docRef =
                          await db.collection("groups").add(groupData);

                      await db
                          .collection("users")
                          .doc(auth.currentUser!.uid)
                          .update({
                        'groups.id': FieldValue.arrayUnion([docRef.id]),
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
  }
}
