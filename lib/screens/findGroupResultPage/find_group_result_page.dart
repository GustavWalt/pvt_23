import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/navigation_bar_widget.dart';

class FindGroupResultPage extends StatefulWidget {
  const FindGroupResultPage({super.key});

  @override
  State<FindGroupResultPage> createState() => _FindGroupResultPageState();
}

class _FindGroupResultPageState extends State<FindGroupResultPage> {
  @override
  Widget build(BuildContext context) {
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
          title: const Text('Groups'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color.fromARGB(255, 147, 48, 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    title: Text('Group name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                    subtitle: Text('Group description',
                        style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: Text("Members: 7/10",
                          style: TextStyle(color: Colors.white)),
                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Info',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        onPressed: () {/*To info about specific group*/},
                      ),
                      TextButton(
                        child: const Text('Join',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        onPressed: () {/*to join group*/},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ])));
  }
}
