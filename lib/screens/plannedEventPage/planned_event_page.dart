import 'package:flutter/material.dart';

import '../../widgets/navigation_bar_widget.dart';

class PlannedEventPage extends StatefulWidget {
  const PlannedEventPage({super.key});

  @override
  State<PlannedEventPage> createState() => _PlannedEventPageState();
}

class _PlannedEventPageState extends State<PlannedEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MenuWidget(),
        backgroundColor: Color.fromARGB(255, 35, 33, 26),
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.account_circle_rounded),
            )
          ],
          leading: const Icon(Icons.arrow_back_rounded),
          title: const Text('Planned event'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Time:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text("15:30",
                      style: TextStyle(color: Colors.white, fontSize: 25))
                ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Date:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text("5/5-2023",
                      style: TextStyle(color: Colors.white, fontSize: 25))
                ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Place:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text("Café söder",
                      style: TextStyle(color: Colors.white, fontSize: 25))
                ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Movies:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Harry Potter",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                        Text("The raiders",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ]),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Attendees:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text("6/10",
                      style: TextStyle(color: Colors.white, fontSize: 25))
                ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromRadius(10),
                  backgroundColor: Color.fromARGB(255, 12, 139, 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                  side: const BorderSide(color: Colors.black, width: 3)),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.check, size: 16),
                    ),
                    TextSpan(
                        text: "Accept",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              onPressed: () {
                /**Backend code needed*/
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromRadius(10),
                  backgroundColor: const Color.fromARGB(255, 147, 48, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                  side: const BorderSide(color: Colors.black, width: 3)),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.close, size: 16),
                    ),
                    TextSpan(
                        text: "Decline",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              onPressed: () {
                /**Backend code needed*/
              },
            ),
          ),
        ]));
  }
}
