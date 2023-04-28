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
  late String _location = '';
  final List<String> _selectedFilms = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _guestLimitController = TextEditingController();
  final TextEditingController _rsvpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize start and end date/time to current date/time
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  void _publishEvent() {
    if (_formKey.currentState!.validate()) {
      // Retrieve data from form
      final eventName = _eventNameController.text;
      final location = _locationController.text;
      final host = _hostController.text;
      final guestLimit = int.tryParse(_guestLimitController.text) ?? 0;
      final rsvp = _rsvpController.text;
      final startDate = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        _startTime.hour,
        _startTime.minute,
      );
      // final startTime = _startTime;
      final endDate = DateTime(
        _endDate.year,
        _endDate.month,
        _endDate.day,
        _endTime.hour,
        _endTime.minute,
      );
      // final endTime = _endTime;
      final films = _selectedFilms.toList();

      // Publish event
      // TODO: Add your publish event code here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Form(
        key: _formKey,
        child: // const SizedBox(height: 500),
            ListView(
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
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Movie Selection',
              ),
              onChanged: (value) {
                setState(() {
                  _selectedFilms.add(value);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter at least one movie selection';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Host',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event host';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Guest Limit',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter guest limit';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'RSVP',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter RSVP information';
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
            const SizedBox(height: 35.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 60),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Get all form data
                  final eventName = _eventNameController.text;
                  final location = _location;
                  final movieSelection = _selectedFilms;
                  final host = _hostController.text;
                  final guestLimit = int.parse(_guestLimitController.text);
                  final rsvp = _rsvpController.text;
                  final startDate = _startDate;
                  final startTime = _startTime;
                  final endDate = _endDate;
                  final endTime = _endTime;
                  final films = _selectedFilms.toList();

                  // TODO: Add code to publish event using the form data

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Event published')),
                  );
                }
              },
              child: const Text('Publish Event'),
            )
          ],
        ),
      ),
    );
  }
}
