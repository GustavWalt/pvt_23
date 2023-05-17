import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../widgets/navigation_bar_widget.dart';
import '../FindNewGroupPage/find_new_group_page.dart';

class FindGroupResultPage extends StatefulWidget {
  Stream<QuerySnapshot<Map<String, dynamic>>>? foundGroups;
  FindGroupResultPage({super.key, this.foundGroups});

  @override
  State<FindGroupResultPage> createState() => _FindGroupResultPageState();
}

class _FindGroupResultPageState extends State<FindGroupResultPage> {
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white)),
                        subtitle: Text(data['description'],
                            style: TextStyle(color: Colors.white)),
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
    /*body: Center(
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
                        onPressed: () {
                          //Do something
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]))*/
  }
}
