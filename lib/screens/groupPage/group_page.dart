import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

import '../../providers/group_id_provider.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  List _items = [];

  @override
  Widget build(BuildContext context) {
    final groupIdProvider = Provider.of<GroupIdProvider>(context);
    String currentGroupId = groupIdProvider.fetchCurrentGroupId;
    final Stream<QuerySnapshot> _groupsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('groups')
        .snapshots();
    _groupsStream.forEach((element) {
      element.docs.forEach((element) {
        _items.add(element.data());
      });
    });
    return StreamBuilder<QuerySnapshot>(
      stream: _groupsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          backgroundColor: Color.fromARGB(255, 35, 33, 26),
          bottomNavigationBar: const MenuWidget(),
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
            title: const Text('Groups'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                ),
                Container(
                  height: 120.0,
                  width: 150.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/group_page_picture.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                ),
                _items.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: 80,
                                padding:
                                    const EdgeInsets.fromLTRB(55, 8, 55, 8),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                      backgroundColor:
                                          Color.fromARGB(255, 147, 48, 48),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                    child: Text(
                                      _items[index]["name"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      final Stream<QuerySnapshot>
                                          selectedGroup = FirebaseFirestore
                                              .instance
                                              .collection('groups')
                                              .where("name",
                                                  isEqualTo: _items[index]
                                                      ["name"])
                                              .snapshots();

                                      context.goNamed(
                                        "selected_group_page",
                                        extra: selectedGroup,
                                      );
                                    }));
                          },
                        ),
                      )
                    : Container(),
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
                        onPressed: () => context.go('/create_group_page'),
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
                                  child: Icon(Icons.search, size: 16),
                                ),
                                TextSpan(
                                    text: "Find groups",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ],
                            ),
                          ),
                          onPressed: () => context.go('/find_new_group_page'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
