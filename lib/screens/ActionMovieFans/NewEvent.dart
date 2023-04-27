import 'package:flutter/material.dart';

//NEW EVENT PAGE
class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late DateTime _startDate;
  late DateTime _endDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  final String _location = '';
  final List<String> _selectedFilms = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize start and end date/time to current date/time
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Event Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text:
                      '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                    ),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null && pickedDate != _startDate) {
                        setState(() {
                          _startDate = pickedDate;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: '${_startTime.format(context)}'),
                    decoration: const InputDecoration(
                      labelText: 'Start Time',
                    ),
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _startTime,
                      );
                      if (pickedTime != null && pickedTime != _startTime) {
                        setState(() {
                          _startTime = pickedTime;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text:
                      '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                    ),
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                    ),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _endDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null && pickedDate != _endDate) {
                        setState(() {
                          _endDate = pickedDate;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: '${_startTime.format(context)}'),
                    decoration: const InputDecoration(
                      labelText: 'End Time',
                    ),
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _endTime,
                      );
                      if (pickedTime != null && pickedTime != _endTime) {
                        setState(() {
                          _endTime = pickedTime;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
