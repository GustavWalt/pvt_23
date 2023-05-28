import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/group_id_provider.dart';
import '../../widgets/navigation_bar_widget.dart';

import 'package:social_share/social_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  String eventDescription = "";

  @override
  Widget build(BuildContext context) {
    final groupIdProvider = Provider.of<GroupIdProvider>(context);
    String currentGroupId = groupIdProvider.fetchCurrentGroupId;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    final uid = currentUser!.uid;
    final db = FirebaseFirestore.instance;

    Map? event = widget.eventInfo;
    if (event!['eventName'] != null) {
      var dt = DateTime.fromMicrosecondsSinceEpoch(event['startDate']);
      eventName = event['eventName'];
      eventDate1 = dt.toString();
      eventTime1 = event['startTime'];
      eventPlace = event['location'];
      eventMovie = event['movieName'];
      eventTime = eventTime1.substring(10, 15);
      eventDate = eventDate1.substring(0, 10);
      eventDescription = event['eventDescription'];
    } else {
      eventName = "No upcoming events yet!";
      eventDate = "N/A";
      eventTime = "N/A";
      eventPlace = "N/A";
      eventMovie = "N/A";
      eventDescription = "N/A";
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
          leading: BackButton(
            onPressed: () {
              context.go("/group_page");
            },
          ),
          title: Text(eventName),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: ListView(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(330, 20, 0, 0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromRadius(25),
                  backgroundColor: Color.fromARGB(255, 64, 122, 83),
                  shape: const CircleBorder(
                    side: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: const Icon(Icons.edit),
                onPressed: () async {
                  String adminId = "";
                  await db.collection("groups").doc(currentGroupId).get().then(
                        (value) => adminId = value["admin"],
                      );

                  if (uid == adminId) {
                    context.go(
                      "/create_event_page",
                    );
                    return;
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "You are not the admin of this group!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
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

          Container(
            padding: EdgeInsets.fromLTRB(50, 40, 0, 10),
            child: const Text("Description:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Text(
              eventDescription,
              style: TextStyle(color: Colors.white, fontSize: 17),
              textAlign: TextAlign.left,
            ),
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
          const Padding(
            padding: EdgeInsets.all(30),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(110, 30, 110, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromRadius(10),
                  backgroundColor: Color.fromARGB(255, 39, 164, 222),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  side: const BorderSide(color: Colors.black, width: 2)),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(FontAwesomeIcons.twitter, size: 16),
                    ),
                    TextSpan(
                        text: "Share to twitter",
                        style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
              onPressed: () {
                SocialShare.shareTwitter(
                    "Using the app Clique I join a film club event called ${eventName} at ${eventTime} on ${eventDate} at ${eventPlace} to watch ${eventMovie}! Join me!",
                    hashtags: ["Clique", "FilmClub", "${eventMovie}"]);
              },
            ),
          ),
        ]));
  }
}
