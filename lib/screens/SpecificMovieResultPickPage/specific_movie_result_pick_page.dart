import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

import '../../logic/movie_class.dart';
import '../SearchPage/search_page.dart';

class SpecificMovieResultPickPage extends StatelessWidget {
  Movie? movie;
  SpecificMovieResultPickPage({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 33, 26),
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.account_circle_rounded),
            )
          ],
          leading: BackButton(
            onPressed: () {
              context.go("/search_pick_page");
            },
          ),
          title: const Text('Movie'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        bottomNavigationBar: const MenuWidget(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
              child: Row(
                children: [
                  Container(
                      child: Image.network(
                    movie!.poster,
                    height: 180,
                    width: 125,
                  )),
                  Container(
                      height: 150,
                      width: 182,
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie!.title,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(movie!.year,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ),
                                Text(movie!.imdbRating,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text(" (${movie!.imdbVotes})",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(0),
                              child: Text(movie!.genre,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 185, 185, 185))))
                        ],
                      ))
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description",
                        style: TextStyle(fontSize: 35, color: Colors.white)),
                    Text(movie!.plot,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                )),
            Container(
              height: 65,
              padding: const EdgeInsets.fromLTRB(115, 0, 115, 0),
              child: Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromRadius(10),
                    backgroundColor: const Color.fromARGB(255, 147, 48, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(20),
                    side: const BorderSide(color: Colors.black, width: 2)),
                child: const Text("Pick Movie",
                    style: TextStyle(
                      fontSize: 17,
                    )),
                onPressed: () {
                  context.goNamed("create_event_page", extra: movie);
                },
              )),
            )
          ],
        ));
  }
}
