import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/screens/groupPage/group_page.dart';
import '../../widgets/navigation_bar_widget.dart';
import '../FindNewGroupPage/find_new_group_page.dart';

class FindGroupResultPage extends StatefulWidget {
  Stream<QuerySnapshot<Map<String, dynamic>>>? foundGroups;
  FindGroupResultPage({super.key, this.foundGroups});

  @override
  State<FindGroupResultPage> createState() => _FindGroupResultPageState();
}

class _FindGroupResultPageState extends State<FindGroupResultPage> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.foundGroups,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

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
                    context.go("/find_new_group_page");
                  },
                );
              },
            ),
            title: const Text('Found groups'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              String docId = document.id;
              return Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color.fromARGB(255, 147, 48, 48),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(data['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white)),
                        subtitle: Text(data['description'],
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 5),
                          child: Text("${"Genre: " + data['genre'].toString()}",
                              style: const TextStyle(color: Colors.white))),
                      Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 5),
                          child: Text(
                              "${"Discussion level: " + data['level'].toString()}",
                              style: const TextStyle(color: Colors.white))),
                      Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text(
                              "${"Members: " + data['members'].toString() + "/" + data['size'].toString()}",
                              style: const TextStyle(color: Colors.white))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Join',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            onPressed: () async {
                              final FirebaseAuth auth = FirebaseAuth.instance;
                              final User? currentUser = auth.currentUser;
                              final uid = currentUser!.uid;

                              List _items = [];
                              Map<String, dynamic> groups2 = {};
                              bool userIsInGroup = false;

                              var db2 = FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(auth.currentUser!.uid);

                              await db2
                                  .get()
                                  .then((value) => groups2 = value["groups"]);
                              groups2.forEach((key, value) {
                                _items = value;
                              });

                              for (var i = 0; i < _items.length; i++) {
                                if (_items[i] == docId) {
                                  userIsInGroup = true;
                                }
                              }

                              if (userIsInGroup) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "You are already part of that group!"),
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
                              } else if (data['members'] >=
                                  int.parse(data['size'])) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "This group is already full!"),
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
                                await db
                                    .collection("users")
                                    .doc(auth.currentUser!.uid)
                                    .update({
                                  'groups.id': FieldValue.arrayUnion([docId]),
                                });

                                await db
                                    .collection("groups")
                                    .doc(docId)
                                    .update({
                                  "members": FieldValue.increment(1),
                                });
                                context.go('/group_page');
                              }
                              userIsInGroup = false;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
