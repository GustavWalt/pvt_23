import 'dart:convert';
import 'package:flutter/src/material/range_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

const List<String> movieImages = <String>[
  'https://media.istockphoto.com/id/1450589928/photo/group-of-people-enjoying-a-movie-at-the-outdoors-cinema.jpg?b=1&s=170667a&w=0&k=20&c=CHNvCNGtYaFBlg0y0aO0S7oMuBRIj-qfZhd5qIidfcI=',
  'https://images.unsplash.com/photo-1608170825938-a8ea0305d46c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW92aWUlMjB0aGVhdGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1vdmllJTIwdGhlYXRlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1vdmllJTIwdGhlYXRlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1vdmllJTIwdGhlYXRlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  '',
  '',
];

const List<String> listDecades = <String>[
  "Harry Potter",
  "Movie 2",
  "Movie 3",
  "Movie 4",
  "Movie 5",
  "Movie 6",
  "Movie 7",
  "Movie 8"
];

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({Key? key}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MenuWidget(),
      backgroundColor: const Color.fromARGB(255, 35, 33, 26),
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.account_circle_rounded),
          )
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.go("/search_page");
              },
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Results',
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
        child: GridView.builder(
          itemCount: movieImages.length,
          itemBuilder: (context, index) {
            GestureDetector(
              onTap: () {},
            );

            return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(movieImages[index]),
                        fit: BoxFit.cover)));
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 50,
            mainAxisSpacing: 30,
          ),
        ),
      )),
    );
  }
}
