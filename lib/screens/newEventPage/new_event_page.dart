import 'package:flutter/material.dart';
import '../../widgets/navigation_bar_widget.dart';
import 'package:go_router/go_router.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  late DateTime _startDate;
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
    _startDate = DateTime.now();
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
        title: const Text('Create new event'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: // const SizedBox(height: 500),
            ListView(
          children: [
            Stack(children: <Widget>[
              Container(
                  height: 90,
                  width: double.infinity,
                  color: const Color.fromARGB(255, 147, 48, 48)),
              const Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color.fromARGB(255, 189, 194, 197),
                        child: CircleAvatar(
                          radius: 57,
                          backgroundImage: AssetImage("assets/images/wes.png"),
                        ),
                      ))),
              const Card(
                margin: EdgeInsets.fromLTRB(30, 150, 30, 8),
                color: Colors.transparent,
              )
            ]),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextFormField(
                cursorColor: const Color.fromARGB(255, 147, 48, 48),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 147, 48, 48)),
                  ),
                  labelText: 'Event Name',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 24),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event name';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextFormField(
                cursorColor: const Color.fromARGB(255, 147, 48, 48),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 147, 48, 48)),
                  ),
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 24),
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
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextFormField(
                cursorColor: const Color.fromARGB(255, 147, 48, 48),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 147, 48, 48)),
                  ),
                  labelText: 'Movie Selection',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 24),
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
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 60),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text:
                            '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 147, 48, 48)),
                        ),
                        labelText: 'Start Date',
                        labelStyle: TextStyle(color: Colors.white),
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: _startTime.format(context)),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 147, 48, 48)),
                        ),
                        labelText: 'Start Time',
                        labelStyle: TextStyle(color: Colors.white),
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(130, 0, 130, 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromRadius(10),
                    backgroundColor: const Color.fromARGB(255, 147, 48, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(15),
                    side: const BorderSide(color: Colors.black, width: 0)),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.calendar_today, size: 16),
                      ),
                      TextSpan(
                          text: " Publish Event",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                onPressed: () => context.go("/"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
