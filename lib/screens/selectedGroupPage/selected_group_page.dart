import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/providers/group_id_provider.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../providers/navigation_bar_provider.dart';

class SelectedGroupPage extends StatefulWidget {
  Stream<QuerySnapshot<Map<String, dynamic>>>? selectedGroup;
  SelectedGroupPage({super.key, this.selectedGroup});
  @override
  _SelectedGroupPageState createState() => _SelectedGroupPageState();
}

class _SelectedGroupPageState extends State<SelectedGroupPage> {
  List _groupInfo = [];

  FirebaseFirestore db = FirebaseFirestore.instance;
  Map _eventInfo = {};

  Future<List> getUsers(List memberIds) async {
    List _members = [];
    _members.clear();
    for (var i = 0; i < memberIds.length; i++) {
      await db.collection("users").doc(memberIds[i]).get().then((value) => {
            _members.add(value["fullname"]),
          });
    }
    return _members;
  }

  @override
  Widget build(BuildContext context) {
    final navigationBarProvider = Provider.of<NavigationBarProvider>(context);
    final groupIdProvider = Provider.of<GroupIdProvider>(context);
    String currentGroupId = groupIdProvider.fetchCurrentGroupId;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    final uid = currentUser!.uid;

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
          if (_groupInfo[0]["event"] != null) {
            _eventInfo.addAll(_groupInfo[0]["event"]);
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (snapshot.data!.docs.isEmpty) {
              context.go("/group_page");
            } else if (currentGroupId != snapshot.data!.docs[0].id) {
              groupIdProvider.updateGroupId(snapshot.data!.docs[0].id);
            }
          });

          return FutureBuilder<dynamic>(
              future: getUsers(_groupInfo[0]['memberId']),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                List<dynamic> memberList = [""];
                if (snapshot.data != null) {
                  memberList = snapshot.data;
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
                    leading: BackButton(
                      onPressed: () {
                        context.go("/group_page");
                      },
                    ),
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
                                      backgroundImage: AssetImage(
                                          "assets/images/no-image.png"),
                                    ),
                                  ))),
                          Row(children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(275, 20, 0, 0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromRadius(25),
                                    backgroundColor:
                                        Color.fromARGB(255, 64, 122, 83),
                                    shape: const CircleBorder(
                                      side: const BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                  ),
                                  child: const Icon(Icons.chat),
                                  onPressed: () async {
                                    final Stream<QuerySnapshot> selectedGroup =
                                        FirebaseFirestore.instance
                                            .collection('groups')
                                            .where("name",
                                                isEqualTo: _groupInfo[0]
                                                    ["name"])
                                            .snapshots();
                                    context.goNamed(
                                      "chat_page",
                                      extra: selectedGroup,
                                    );
                                  }),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromRadius(25),
                                    backgroundColor:
                                        Color.fromARGB(255, 64, 122, 83),
                                    shape: const CircleBorder(
                                      side: const BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                  ),
                                  child: const Icon(Icons.edit),
                                  onPressed: () async {
                                    if (uid == _groupInfo[0]['admin']) {
                                      final Stream<QuerySnapshot>
                                          selectedGroup = FirebaseFirestore
                                              .instance
                                              .collection('groups')
                                              .where("name",
                                                  isEqualTo: _groupInfo[0]
                                                      ["name"])
                                              .snapshots();
                                      context.goNamed(
                                        "create_group_page_edit",
                                        extra: selectedGroup,
                                      );
                                      return;
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content: const Text(
                                                "You are not the admin of this group!"),
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
                                    }
                                  }),
                            ),
                          ]),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 150, 30, 40),
                            color: Colors.transparent,
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          color: Colors.transparent,
                          child: Text(
                              "Members ${_groupInfo[0]["members"]}/${_groupInfo[0]["size"]}:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(30, 5, 30, 15),
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List<Widget>.generate(memberList.length,
                                  (index) {
                                return Container(
                                    child: Text(memberList[index].toString(),
                                        style: TextStyle(color: Colors.white)));
                              }),
                            )),
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.transparent,
                          elevation: 0,
                          child: Column(children: <Widget>[
                            ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
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
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 120),
                        ),
                        Container(
                          height: 65,
                          padding: const EdgeInsets.fromLTRB(85, 8, 85, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromRadius(30),
                                  backgroundColor:
                                      Color.fromARGB(255, 147, 48, 48),
                                  shape: const CircleBorder(
                                    side: const BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                ),
                                child:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  if (uid == _groupInfo[0]['admin']) {
                                    if (_groupInfo[0]['event'] != null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content: const Text(
                                                "You have already created an event. Are you sure you want to replace it by making a new one?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context.goNamed(
                                                      'create_event_page');
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    }
                                    context.goNamed('create_event_page');
                                    return;
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Error"),
                                          content: const Text(
                                              "You are not the admin of this group!"),
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
                                  }
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromRadius(10),
                                      backgroundColor:
                                          Color.fromARGB(255, 147, 48, 48),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 15),
                                      side: const BorderSide(
                                          color: Colors.black, width: 2)),
                                  child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.calendar_month,
                                              size: 17),
                                        ),
                                        TextSpan(
                                            text: "Upcoming event",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    context.goNamed("planned_event_page",
                                        extra: _eventInfo);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(90, 0, 85, 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromRadius(10),
                                backgroundColor:
                                    Color.fromARGB(255, 147, 48, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 13, 20, 13),
                                side: const BorderSide(
                                    color: Colors.black, width: 2)),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Leave group",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: const Text("Confirmation"),
                                    content: const Text(
                                        "Are you sure you want to leave the group?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(dialogContext).pop();

                                          if (uid == _groupInfo[0]['admin']) {
                                            Map<String, dynamic> groupsInUser =
                                                {};
                                            var users = await db
                                                .collection("users")
                                                .get()
                                                .then((value) => value.docs
                                                        .forEach((element) {
                                                      groupsInUser =
                                                          element["groups"];

                                                      groupsInUser.forEach(
                                                          (key, value) async {
                                                        for (var i = 0;
                                                            i < value.length;
                                                            i++) {
                                                          if (value[i] ==
                                                              currentGroupId) {
                                                            await db
                                                                .collection(
                                                                    "users")
                                                                .doc(element.id)
                                                                .update({
                                                              'groups.id':
                                                                  FieldValue
                                                                      .arrayRemove([
                                                                currentGroupId
                                                              ]),
                                                            });
                                                          }
                                                        }
                                                      });
                                                    }));

                                            await db
                                                .collection("groups")
                                                .doc(currentGroupId)
                                                .delete();
                                          } else {
                                            await db
                                                .collection("groups")
                                                .doc(currentGroupId)
                                                .update({
                                              "members":
                                                  _groupInfo[0]['members'] - 1,
                                              'memberId':
                                                  FieldValue.arrayRemove([uid])
                                            });

                                            await db
                                                .collection("users")
                                                .doc(auth.currentUser!.uid)
                                                .update({
                                              'groups.id':
                                                  FieldValue.arrayRemove(
                                                      [currentGroupId]),
                                            });

                                            context.go('/group_page');
                                          }
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
