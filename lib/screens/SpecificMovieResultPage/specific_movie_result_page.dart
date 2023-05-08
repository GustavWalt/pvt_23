import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class SpecificMovieResultPage extends StatelessWidget {
  const SpecificMovieResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () => context.go("/login_page"),
          ),
        ),
        bottomNavigationBar: MenuWidget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(50, 100, 50, 50),
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
                      padding: EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Harry Potter", style: TextStyle(fontSize: 20)),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/amazon.png",
                                  height: 25,
                                  width: 25,
                                ),
                                Image.asset(
                                  "assets/images/netflix.png",
                                  height: 25,
                                  width: 25,
                                ),
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
                padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description",
                        style: TextStyle(
                          fontSize: 35,
                        )),
                    Text(
                        "Harry Potter thinks he is an ordinary boy celebrating his 11th birthday, but he is far from right. A giant named Hagrid appears, and gives Harry the all important news. He is a wizard.But not everything is quiet at Hogwarts as Harry suspects someone is planning to steal the sorcerer's stone.Adaptation of the first of J.K.",
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ))
          ],
        ));
  }
}
