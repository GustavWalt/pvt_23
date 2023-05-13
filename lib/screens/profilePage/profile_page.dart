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
            padding: const EdgeInsets.all(0),
            child: Column(children: [
              _items.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Stack(children: <Widget>[
                              Container(
                                  height: 90,
                                  width: double.infinity,
                                  color:
                                      const Color.fromARGB(255, 147, 48, 48)),
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
                                              "assets/images/profile1.png"),
                                        ),
                                      ))),
                              Card(
                                margin:
                                    const EdgeInsets.fromLTRB(30, 130, 30, 8),
                                color: Colors.transparent,
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                            ]),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              color: Colors.transparent,
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
                                  horizontal: 30, vertical: 8),
                              color: Colors.transparent,
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
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              color: Colors.transparent,
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
                                padding: EdgeInsets.all(18),
                                child: Text("Update",
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
