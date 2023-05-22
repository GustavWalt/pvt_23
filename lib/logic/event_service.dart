import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/CalendarPage/calendar_page.dart';

class EventService {
  static Future<List<Event>> getAllEventsForUser(String userId) async {
    List<Event> allEvents = [];

    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('groups')
        .get();

    for (QueryDocumentSnapshot groupDoc in userSnapshot.docs) {
      QuerySnapshot eventsSnapshot =
          await groupDoc.reference.collection('events').get();

      Map<String, dynamic>? groupData =
          groupDoc.data() as Map<String, dynamic>?;

      if (groupData != null && groupData.containsKey('event')) {
        Map<String, dynamic>? eventData =
            groupData['event'] as Map<String, dynamic>?;

        if (eventData != null) {
          String timeValue =
              eventData['startTime'].replaceAll(RegExp(r'[^\d:]'), '');
          List<String> parts = timeValue.split(':');
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1]);
          TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);

          Event event = Event(
            eventName: eventData['eventName'],
            location: eventData['location'],
            movieName: eventData['movieName'],
            startDate:
                DateTime.fromMicrosecondsSinceEpoch(eventData['startDate']),
            startTime: timeOfDay,
          );

          allEvents.add(event);
        }
      }
    }

    return allEvents;
  }
}
