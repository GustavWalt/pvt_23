import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SelectedGroupPage extends StatefulWidget {
  const SelectedGroupPage({Key? key}) : super(key: key);
  @override
  _SelectedGroupPageState createState() => _SelectedGroupPageState();
}

class _SelectedGroupPageState extends State<SelectedGroupPage> {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  //snapshot.data!.get("fullname"),

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
        title: const Text('Group Name'),
        backgroundColor: Colors.black,
        centerTitle: true,
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
                                    AssetImage("assets/images/wes.png"),
                              ),
                            ))),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 150, 30, 0),
                      color: Colors.transparent,
                      child: Column(children: const <Widget>[
                        ListTile(
                          title: Text('Members: 3/10',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ]),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(30, 200, 30, 10),
                        color: Colors.transparent,
                        child: Row(children: const <Widget>[
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1.png"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1.png"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1.png"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1bw.png"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1bw.png"),
                            ),
                          ),
                        ])),
                    Container(
                        margin: const EdgeInsets.fromLTRB(30, 270, 30, 10),
                        color: Colors.transparent,
                        child: Row(children: const <Widget>[
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1bw.png"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1bw.png"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1bw.png"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1bw.png"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1bw.png"),
                            ),
                          ),
                        ])),
                  ]),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Column(children: const <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Description:',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        subtitle:
                            Text('We like Wes Anderson and symmetrical things',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                      ),
                    ]),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Column(children: const <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Genre:',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        subtitle: Text('Director',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ]),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Column(children: const <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Level:',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        subtitle: Text('Expert',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: TextButton(
                      child: const Text(
                        "New Event",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => context.go('/'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(135, 10, 135, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromRadius(10),
                          backgroundColor:
                              const Color.fromARGB(255, 147, 48, 48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(15),
                          side:
                              const BorderSide(color: Colors.black, width: 0)),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.calendar_today, size: 16),
                            ),
                            TextSpan(
                                text: " Upcoming Event",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      onPressed: () => context.go("/"),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
