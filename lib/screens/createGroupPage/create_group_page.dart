import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/navigation_bar_widget.dart';

const List<String> genres = <String>['Horror', 'Comedy', 'Sci-fi'];
const List<String> level = <String>["1", "2", "3"];
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
  "11",
  "12",
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.account_circle_rounded),
          )
        ],
        leading: const Icon(Icons.arrow_back_rounded),
        title: const Text('Create group'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 600,
                  color: Color.fromARGB(255, 147, 48, 48),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromARGB(255, 44, 44, 44),
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage:
                                AssetImage("assets/images/logo1.png"),
                          ),
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Choose name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          /*Dunno yet*/
                        },
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
          Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final User? currentUser = auth.currentUser;
                    final uid = currentUser!.uid;

                    final groupData = <String, dynamic>{
                      "description": _descriptionController.text,
                      "genre": genreValue,
                      "level": levelValue,
                      "name": _nameController.text,
                      "size": sizeValue,
                      "admin": uid
                    };

                    final userData = <String, dynamic>{"uid": uid};

                    DocumentReference docRef =
                        await db.collection("groups").add(groupData);

                    print(docRef.toString());

                    await db
                        .collection("groups")
                        .doc(docRef.id)
                        .collection("users")
                        .add(userData);

                    final roomData = <String, dynamic>{
                      "name": _nameController.text
                    };

                    await db.collection("rooms").doc(docRef.id).set(roomData);
                  }))
        ],
      ),
    );
  }
}
