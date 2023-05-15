import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class SpecificMovieResultPage extends StatelessWidget {
  const SpecificMovieResultPage({super.key});

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
          leading: const Icon(Icons.arrow_back_rounded),
          title: const Text('Movie'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        bottomNavigationBar: const MenuWidget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
              child: Row(
                children: [
                  Container(
                      child: Image.asset(
                    "assets/images/harry_potter.jpg",
                    height: 180,
                    width: 125,
                  )),
                  Container(
                      height: 75,
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Harry Potter",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/amazon.png",
                                  height: 25,
                                  width: 25,
                                ),
                                Image.asset("assets/images/netflix.png",
                                    height: 25,
                                    width: 25,
                                    color:
                                        const Color.fromARGB(255, 160, 23, 23)),
                                Image.asset(
                                  "assets/images/hbo.png",
                                  height: 25,
                                  width: 25,
                                )
                              ],
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Description",
                        style: TextStyle(fontSize: 35, color: Colors.white)),
                    Text(
                        "Harry Potter thinks he is an ordinary boy celebrating his 11th birthday, but he is far from right. A giant named Hagrid appears, and gives Harry the all important news. He is a wizard.But not everything is quiet at Hogwarts as Harry suspects someone is planning to steal the sorcerer's stone.Adaptation of the first of J.K.",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                )),
            Container(
              height: 65,
              padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
              child: Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    minimumSize: const Size.fromRadius(80),
                    backgroundColor: const Color.fromARGB(255, 143, 28, 28)),
                child: const Text("Pick Movie"),
                onPressed: () => context.go('/'),
              )),
            )
          ],
        ));
  }
}
