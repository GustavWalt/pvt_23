import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/providers/group_id_provider.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
];

class SelectedGroupPageEdit extends StatefulWidget {
  List? groupInfo;

  SelectedGroupPageEdit({super.key, this.groupInfo});
  @override
  _SelectedGroupPageEditState createState() => _SelectedGroupPageEditState();
}

class _SelectedGroupPageEditState extends State<SelectedGroupPageEdit> {
  List _groupInfo = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String levelValue = "";
  String genreValue = "";
  String sizeValue = "";

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    final uid = currentUser!.uid;
    final groupIdProvider = Provider.of<GroupIdProvider>(context);
    String currentGroupId = groupIdProvider.fetchCurrentGroupId;
    List? groupInfo = widget.groupInfo;

    return Scaffold(
      bottomNavigationBar: const MenuWidget(),
      backgroundColor: const Color.fromARGB(255, 35, 33, 26),
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
        title: Text(groupInfo![0]["name"]),
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
                    children: [
                      const Padding(
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
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                    TextSpan(
                        text: "Update",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              onPressed: () async {
                if (_nameController.text == "") {
                  _nameController.text = groupInfo[0]["name"];
                }
                if (_descriptionController.text == "") {
                  _descriptionController.text = groupInfo[0]["description"];
                }
                if (sizeValue == "") {
                  sizeValue = groupInfo[0]["size"].toString();
                }
                if (genreValue != "") {
                  genreValue = groupInfo[0]["genre"];
                }
                if (levelValue == "") {
                  levelValue = groupInfo[0]["level"];
                }

                await db.collection("groups").doc(currentGroupId).update({
                  "name": _nameController.text,
                  "description": _descriptionController.text,
                  "size": sizeValue,
                  "genre": genreValue,
                  "level": levelValue,
                });
                await db
                    .collection("users")
                    .doc(auth.currentUser!.uid)
                    .collection("groups")
                    .doc(currentGroupId)
                    .update({
                  "name": _nameController.text,
                  "description": _descriptionController.text,
                  "size": sizeValue,
                  "genre": genreValue,
                  "level": levelValue,
                });

                context.go("/group_page");
              },
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
                    TextSpan(
                        text: "Delete group",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              onPressed: () async {
                await db.collection("groups").doc(currentGroupId).delete();
                await db
                    .collection("users")
                    .doc(auth.currentUser!.uid)
                    .collection("groups")
                    .doc(currentGroupId)
                    .delete();

                context.go("/group_page");
              },
            ),
          ),
        ],
      ),
    );
  }
}
