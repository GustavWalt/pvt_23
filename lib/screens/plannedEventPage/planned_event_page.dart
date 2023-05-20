import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/group_id_provider.dart';
import '../../widgets/navigation_bar_widget.dart';

class PlannedEventPage extends StatefulWidget {
  Map? eventInfo;
  PlannedEventPage({super.key, this.eventInfo});

  @override
  State<PlannedEventPage> createState() => _PlannedEventPageState();
}

class _PlannedEventPageState extends State<PlannedEventPage> {
  String eventName = "";
  String eventDate1 = "";
  String eventDate = "";
  String eventTime = "";
  String eventTime1 = "";
  String eventPlace = "";
  String eventMovie = "";

  @override
  Widget build(BuildContext context) {
    Map? event = widget.eventInfo;
    if (event != null) {
      eventName = event['eventName'];
      eventDate1 = event['startDate'];
      eventTime1 = event['startTime'];
      eventPlace = event['location'];
      eventMovie = event['movieName'];
      eventTime = eventTime1.substring(10, 15);
      eventDate = eventDate1.substring(0, 10);
    } else {
      eventName = "No upcoming events yet!";
      eventDate = "N/A";
      eventTime = "N/A";
      eventPlace = "N/A";
      eventMovie = "N/A";
    }

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
                  //FUNGERAR INTE ATT GÅ TILLBAKA!!!
                },
              );
            },
          ),
          title: Text(eventName),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Time:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text(eventTime,
                      style: TextStyle(color: Colors.white, fontSize: 25))
                ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Date:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text(eventDate,
                      style: TextStyle(color: Colors.white, fontSize: 25))
                ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Place:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Flexible(
                    child: Text(
                      eventPlace,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      textAlign: TextAlign.right,
                    ),
                  )
                ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Movie:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Flexible(
                    child: Text(
                      eventMovie,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      textAlign: TextAlign.right,
                    ),
                  )
                ]),
          ),
          //HAR TAGIT BORT ATTENDEES FOR NOW!!!!!!
          //HAR TAGIT BORT ATTENDEES FOR NOW!!!!!!
          //HAR TAGIT BORT ATTENDEES FOR NOW!!!!!!
          //HAR TAGIT BORT ATTENDEES FOR NOW!!!!!!
          //HAR TAGIT BORT ATTENDEES FOR NOW!!!!!!

          /*Padding(
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
          ),*/
          Container(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
