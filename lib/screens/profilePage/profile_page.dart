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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text(
            'Profile',
          ),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            Card(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('Username',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                        _items[index]["username"],
                                      ),
                                    ),
                                  ]),
                            ),
                            Card(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('Email address',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                        _items[index]["email"],
                                      ),
                                    ),
                                  ]),
                            ),
                            Card(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('Password',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                        _items[index]["password"],
                                      ),
                                    ),
                                  ]),
                            ),
                            Card(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('Description',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                        _items[index]["description"],
                                      ),
                                    ),
                                  ]),
                            ),
                            const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("Edit profile",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)))
                          ]);
                        },
                      ),
                    )
                  : Container(),
              Container(
                  height: 65,
                  padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromRadius(80),
                        backgroundColor: Colors.black),
                    child: const Text("Log out"),
                    onPressed: () => context.go('/'),
                  )),
            ])));
  }
}
