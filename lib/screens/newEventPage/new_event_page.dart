import 'package:flutter/material.dart';

//NEW EVENT PAGE

class NewEventPage extends StatefulWidget {
  const NewEventPage({Key? key}) : super(key: key);

  @override
  _CreateNewEventPageState createState() => _CreateNewEventPageState();
}

class _CreateNewEventPageState extends State<NewEventPage> {
  late DateTime _startDate;
  late DateTime _endDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late String _location = '';
  late List<String> _selectedFilms = [];
  final _formKey = GlobalKey<FormState>();
  late bool _isPublishing = false;

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

  Future<void> _publishEvent() async {
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
      // Show confirmation dialog
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to publish this event?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      if (confirmed != null && confirmed) {
        try {
          // Publish event
          // TODO: Add your publish event code here

          setState(() {
            _isPublishing = false;
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Event published successfully'),
            ),
          );
        } catch (e) {
          setState(() {
            _isPublishing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to publish event: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new Event'),
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
                    controller:
                    TextEditingController(text: _startTime.format(context)),
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
                    controller:
                    TextEditingController(text: _endTime.format(context)),
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
              //onpressed
              onPressed: () {
                _publishEvent();
              },

              child: const Text('Publish Event'),
            )
          ],
        ),
      ),
    );
  }
}
