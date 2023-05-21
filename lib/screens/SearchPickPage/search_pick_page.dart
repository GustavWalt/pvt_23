import 'dart:convert';
import 'package:flutter/src/material/range_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

import '../../logic/movie_class.dart';

class SearchPickPage extends StatefulWidget {
  const SearchPickPage({Key? key}) : super(key: key);

  @override
  _SearchPickPageState createState() => _SearchPickPageState();
}

class _SearchPickPageState extends State<SearchPickPage> {
  final TextEditingController _searchBarController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Search movie'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(60, 20, 60, 0),
            child: TextField(
              controller: _searchBarController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Movie name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(color: Colors.black, width: 2))),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
            child: TextField(
              controller: _yearController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Specify year (optional)",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(color: Colors.black, width: 2))),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
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
                          text: "Search for movie",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                onPressed: () {
                  fetchMovie().then(
                    (value) => {
                      context.goNamed("specific_movie_result_pick_page",
                          extra: value)
                    },
                  );
                },
              )),
          Container(
            height: 180.0,
            width: 200.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/group_page_picture.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Movie> fetchMovie() async {
    final response = await http.get(Uri.parse(
        'http://www.omdbapi.com/?t=${_searchBarController.text}&y=${_yearController.text}&plot=full&apikey=92943f28'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
