import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/navigation_bar_widget.dart';

//We need to add genres - either manually or through imdb's API.
const List<String> genres = <String>[
  "Genre:",
  'Action',
  'Adventure',
  'Comedy',
  'Drama',
  'Fantasy',
  'Horror',
  'Musicals',
  'Mystery',
  'Romance',
  'Science fiction',
  'Sports',
  'Thriller',
  'Western',
];
const List<String> level = <String>[
  "Discussion level:",
  "Beginner",
  "Intermediate",
  "Expert"
];

class FindNewGroupPage extends StatefulWidget {
  const FindNewGroupPage({super.key});

  @override
  State<FindNewGroupPage> createState() => _FindNewGroupPageState();
}

class _FindNewGroupPageState extends State<FindNewGroupPage> {
  String genreValue = genres.first;
  String levelValue = level.first;

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
                  context.go("/group_page");
                },
              );
            },
          ),
          title: const Text('Find groups'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(15),
          ),
          Container(
            height: 120.0,
            width: 150.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/group_picture.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 40, 100, 7),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Genre",
                  fillColor: Color.fromARGB(255, 209, 217, 223)),
              onChanged: (String? value) {
                setState(() {
                  genreValue = value!;
                });
              },
              items: genres.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 7, 100, 7),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Discussion level",
                  fillColor: Color.fromARGB(255, 209, 217, 223)),
              onChanged: (String? value) {
                setState(() {
                  levelValue = value!;
                });
              },
              items: level.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(30),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromRadius(10),
                    backgroundColor: const Color.fromARGB(255, 147, 48, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(20),
                    side: const BorderSide(color: Colors.black, width: 3)),

                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.add, size: 16),
                      ),
                      TextSpan(
                          text: "Find groups", style: TextStyle(fontSize: 17)),
                    ],
                  ),
                ),
                //Shuold not go to group page, this is placeholder. Should go to available groups.
                onPressed: () {
                  if (genreValue == genres.first && levelValue == level.first) {
                    final Stream<QuerySnapshot<Map<String, dynamic>>>
                        foundGroups = FirebaseFirestore.instance
                            .collection('groups')
                            .snapshots();
                    context.goNamed(
                      "find_group_result_page",
                      extra: foundGroups,
                    );

                    return;
                  } else if (genreValue == genres.first &&
                      levelValue != level.first) {
                    final Stream<QuerySnapshot<Map<String, dynamic>>>
                        foundGroups = FirebaseFirestore.instance
                            .collection('groups')
                            .where('level', isEqualTo: levelValue.toString())
                            .snapshots();
                    context.goNamed(
                      "find_group_result_page",
                      extra: foundGroups,
                    );
                    return;
                  } else if (genreValue != genres.first &&
                      levelValue == level.first) {
                    final Stream<QuerySnapshot<Map<String, dynamic>>>
                        foundGroups = FirebaseFirestore.instance
                            .collection('groups')
                            .where('genre', isEqualTo: genreValue.toString())
                            .snapshots();
                    context.goNamed(
                      "find_group_result_page",
                      extra: foundGroups,
                    );
                    return;
                  } else {
                    final Stream<QuerySnapshot<Map<String, dynamic>>>
                        foundGroups = FirebaseFirestore.instance
                            .collection('groups')
                            .where('genre', isEqualTo: genreValue.toString())
                            .where('level', isEqualTo: levelValue.toString())
                            .snapshots();
                    context.goNamed(
                      "find_group_result_page",
                      extra: foundGroups,
                    );
                  }
                },
              ))
        ])));
  }
}
