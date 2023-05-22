import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../logic/event_service.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<Event> allEvents = [];

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    getEvents();
  }

  void getEvents() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    allEvents = await EventService.getAllEventsForUser(currentUser!.uid);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  var _events = [
    Event(
      eventName: 'Event 1',
      location: 'Location 1',
      movieName: 'Movie 1',
      startDate: DateTime.now(),
      startTime: TimeOfDay.now(),
    ),
    Event(
      eventName: 'Event 2',
      location: 'Location 2',
      movieName: 'Movie 2',
      startDate:
          DateTime.utc(int.parse('2023'), int.parse('10'), int.parse('16')),
      startTime: TimeOfDay.now(),
    ),
  ];

  List<Event> _getEventsForDay(DateTime day) {
    return allEvents
        .where((event) =>
            event.startDate.day == day.day &&
            event.startDate.month == day.month &&
            event.startDate.year == day.year)
        .toList();
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Events'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Event Details'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Event Name: ${value[index].eventName}'),
                                  Text('Location: ${value[index].location}'),
                                  Text('Movie Name: ${value[index].movieName}'),
                                  Text('Start Date: ${value[index].startDate}'),
                                  Text('Start Time: ${value[index].startTime}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text('${value[index].eventName}'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> daysInRange(DateTime start, DateTime end) {
    final days = <DateTime>[];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      days.add(start.add(Duration(days: i)));
    }
    return days;
  }
}

class Event {
  final String eventName;
  final String location;
  final String movieName;
  final DateTime startDate;
  final TimeOfDay startTime;

  const Event({
    required this.eventName,
    required this.location,
    required this.movieName,
    required this.startDate,
    required this.startTime,
  });
}
