import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List _items = [];

  Future<void> readJson() async {
    var jsonText = await rootBundle.loadString('assets/user.json');
    final data = await json.decode(jsonText);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Scaffold(
        bottomNavigationBar: const MenuWidget(),
        backgroundColor: const Color.fromARGB(255, 35, 33, 26),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text(
            'Profil',
          ),
          actions: const [
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.account_circle_rounded,
                  color: Color.fromARGB(255, 147, 48, 48),
                ))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(children: [
              _items.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 38,
                                      backgroundImage:
                                          AssetImage("assets/images/logo1.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  _items[index]["name"],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: const Color.fromARGB(255, 35, 33, 26),
                              elevation: 0,
                              child: Column(children: <Widget>[
                                const ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  title: Text('Username',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 189, 194, 197),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'JaneDoe1',
                                  ),
                                ),
                              ]),
                            ),
                            Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: const Color.fromARGB(255, 35, 33, 26),
                              elevation: 0,
                              child: Column(children: <Widget>[
                                const ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  title: Text('E-mail',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 189, 194, 197),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'janedoe@samplemail.com',
                                  ),
                                ),
                              ]),
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              color: const Color.fromARGB(255, 35, 33, 26),
                              elevation: 0,
                              child: Column(children: <Widget>[
                                const ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  title: Text('Phone number',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 189, 194, 197),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: '+46 70 123 45 67',
                                  ),
                                ),
                              ]),
                            ),
                            Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: const Color.fromARGB(255, 35, 33, 26),
                              elevation: 0,
                              child: Column(children: <Widget>[
                                const ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  title: Text('Password',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 189, 194, 197),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: '************',
                                  ),
                                ),
                              ]),
                            ),
                            const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("Uppdatera",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )))
                          ]);
                        },
                      ),
                    )
                  : Container(),
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromRadius(10),
                        backgroundColor: const Color.fromARGB(255, 147, 48, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(15),
                        side: const BorderSide(color: Colors.black, width: 0)),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.logout, size: 16),
                          ),
                          TextSpan(
                              text: " Log out",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    onPressed: () => context.go('/'),
                  )),
            ])));
  }
}
