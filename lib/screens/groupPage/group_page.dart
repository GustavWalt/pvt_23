import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

import '../chosenGroupPage/chosen_group_page.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List _items = [];

  Future<void> readJson() async {
    var jsonText = await rootBundle.loadString('assets/sampleDB.json');
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
          'Groups',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 80,
                            padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  backgroundColor: Colors.grey),

                              child: Text(
                                _items[index]["name"],
                                style: TextStyle(color: Colors.black),
                              ),

                              //Should not go to group page, should go to view for specific group connected to the id of the buttom pressed.
                              //navigate to ActionFanatics page
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChosenGroupPage()),
                                );
                              },
                            ));
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
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.add, size: 16),
                        ),
                        TextSpan(text: "Find groups"),
                      ],
                    ),
                  ),
                  //Shuold not go to group page, this is placeholder. Should go to available groups.
                  onPressed: () => context.go('/group_page'),
                )),
          ],
        ),
      ),
    );
  }
}
