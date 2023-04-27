import 'package:flutter/material.dart';

import 'NewEvent.dart';

// ActionMovieFans
class ActionFanatics extends StatelessWidget {
  const ActionFanatics({Key? key}) : super(key: key);

  void _goToEventPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EventPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Action Movie Fans'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _goToEventPage(context);
              },
              child: const Text('New Event'),
            ),
            ElevatedButton(
              onPressed: () {
                // Code to create a new event goes here
              },
              child: const Text('Planned Event'),
            ),
            ElevatedButton(
              onPressed: () {
                // Code to invite friends goes here
              },
              child: const Text('Past Event'),
            ),
          ],
        ),
      ),
    );
  }
}
