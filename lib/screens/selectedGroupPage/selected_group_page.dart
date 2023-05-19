import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SelectedGroupPage extends StatefulWidget {
  Stream<QuerySnapshot<Map<String, dynamic>>>? selectedGroup;
  SelectedGroupPage({super.key, this.selectedGroup});
  @override
  _SelectedGroupPageState createState() => _SelectedGroupPageState();
}

class _SelectedGroupPageState extends State<SelectedGroupPage> {
  List _groupInfo = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
              title: Text(_groupInfo[0]["name"]),
              backgroundColor: Colors.black,
              centerTitle: true,
            ),
            body: Padding(
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
                      margin: EdgeInsets.fromLTRB(15, 150, 30, 0),
                      color: Colors.transparent,
                      child: Column(children: <Widget>[
                        ListTile(
                          title: Text("Members:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text("${_groupInfo[0]['members']}/10",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ]),
                    ),

                    //FRAMEWORK FOR IF WE WANT TO INCLUDE LIST OF MEMBERS
                    //FRAMEWORK FOR IF WE WANT TO INCLUDE LIST OF MEMBERS
                    //FRAMEWORK FOR IF WE WANT TO INCLUDE LIST OF MEMBERS
                    //FRAMEWORK FOR IF WE WANT TO INCLUDE LIST OF MEMBERS
                    //FRAMEWORK FOR IF WE WANT TO INCLUDE LIST OF MEMBERS

                    /*Container(
                      margin: const EdgeInsets.fromLTRB(30, 200, 30, 10),
                      color: Colors.transparent,
                      child: Row(
                        children: const <Widget>[
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile1.png"),
                            ),
                          ),
                        ],
                      ),
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
                        ])),*/
                    /*Container(
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
                        ])),*/
                  ]),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Column(children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Description:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(_groupInfo[0]["description"],
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
                    child: Column(children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Genre:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(_groupInfo[0]["genre"],
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
                    child: Column(children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Level:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(_groupInfo[0]["level"],
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ]),
                  ),
                  Container(
                    height: 65,
                    padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromRadius(30),
                            backgroundColor: Color.fromARGB(255, 147, 48, 48),
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                          onPressed: () => context.go('/new_event_page'),
                          // Add create group button functionality here
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromRadius(80),
                                backgroundColor:
                                    Color.fromARGB(255, 147, 48, 48)),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.calendar_month, size: 16),
                                  ),
                                  TextSpan(
                                      text: "Upcoming events",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              ),
                            ),
                            onPressed: () => context.go('/planned_event_page'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
