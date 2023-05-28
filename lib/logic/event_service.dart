import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/calendarPage/calendar_page.dart';

class EventService {
  static Future<List<Event>> getAllEventsForUser(String userId) async {
    List<Event> allEvents = [];
    Map<String, dynamic> groupIds = {};
    List<Map<String, dynamic>> groups = [];
    List _items = [];

    var db = FirebaseFirestore.instance.collection("users").doc(userId);

    await db.get().then((value) => groupIds = value["groups"]);
    groupIds.forEach((key, value) {
      _items = value;
    });

    for (String groupId in _items) {
      DocumentSnapshot<Map<String, dynamic>> groupSnapshot =
          await FirebaseFirestore.instance
              .collection("groups")
              .doc(groupId)
              .get();

      Map<String, dynamic> groupData = groupSnapshot.data()!;
      groups.add(groupData);
    }
    for (var i = 0; i < groups.length; i++) {
      groups[i].forEach((key, value) {
        if (key == 'event') {
          if (value != null) {
            String timeValue =
                value['startTime'].replaceAll(RegExp(r'[^\d:]'), '');
            List<String> parts = timeValue.split(':');
            int hour = int.parse(parts[0]);
            int minute = int.parse(parts[1]);
            TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);

            Event event = Event(
              eventDescription: value['eventDescription'],
              eventName: value['eventName'],
              location: value['location'],
              movieName: value['movieName'],
              startDate:
                  DateTime.fromMicrosecondsSinceEpoch(value['startDate']),
              startTime: timeOfDay,
            );

            allEvents.add(event);
          }
        }
      });
    }

    return allEvents;
  }
}
