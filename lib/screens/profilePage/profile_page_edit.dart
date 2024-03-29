import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePageEdit extends StatefulWidget {
  const ProfilePageEdit({Key? key}) : super(key: key);
  @override
  _ProfilePageEditState createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;

    Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
      return await db.collection("users").doc(user!.uid).get();
    }

    return Scaffold(
      bottomNavigationBar: const MenuWidget(),
      backgroundColor: const Color.fromARGB(255, 35, 33, 26),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Profile',
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  context.go("/profile_page");
                },
                child: Icon(
                  Icons.account_circle,
                  color: Color.fromARGB(255, 147, 48, 48),
                ),
              ))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: ListView(
                children: [
                  Stack(children: <Widget>[
                    Container(
                        height: 90,
                        width: double.infinity,
                        color: const Color.fromARGB(255, 147, 48, 48)),
                    const Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  Color.fromARGB(255, 189, 194, 197),
                              child: CircleAvatar(
                                radius: 57,
                                backgroundImage:
                                    AssetImage("assets/images/profile1.png"),
                              ),
                            ))),
                    Card(
                      margin: const EdgeInsets.fromLTRB(30, 130, 30, 8),
                      color: Colors.transparent,
                      elevation: 0,
                      child: Column(children: <Widget>[
                        const ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          title: Text('Username',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: snapshot.data!.get("fullname"),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Column(children: <Widget>[
                      const ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Phone number',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: snapshot.data!.get("phone").toString(),
                        ),
                      ),
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(18),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(140, 10, 140, 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromRadius(10),
                          backgroundColor:
                              const Color.fromARGB(255, 147, 48, 48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(15),
                          side:
                              const BorderSide(color: Colors.black, width: 2)),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "Update", style: TextStyle(fontSize: 17)),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        if (_nameController.text == "") {
                          _nameController.text = snapshot.data!.get("fullname");
                        }

                        if (_phoneController.text == "") {
                          _phoneController.text =
                              snapshot.data!.get("phone").toString();
                        }

                        await db.collection("users").doc(user!.uid).update({
                          "fullname": _nameController.text,
                          "phone": _phoneController.text,
                        });
                        context.go("/profile_page");
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
