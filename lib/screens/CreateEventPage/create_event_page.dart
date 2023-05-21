import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/movie_class.dart';
import '../../providers/group_id_provider.dart';
import '../../widgets/navigation_bar_widget.dart';
import 'package:go_router/go_router.dart';

class CreateEventPage extends StatefulWidget {
  Movie? movie;
  CreateEventPage({super.key, this.movie});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final db = FirebaseFirestore.instance;
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late String _location = '';
  final _formKey = GlobalKey<FormState>();
  late bool _isPublishing = false;

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _startTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    final groupIdProvider = Provider.of<GroupIdProvider>(context);
    String currentGroupId = groupIdProvider.fetchCurrentGroupId;
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
              Positioned(
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
                          backgroundImage: widget.movie == null
                              ? AssetImage("assets/images/no-image.png")
                              : NetworkImage(widget.movie!.poster)
                                  as ImageProvider,
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
                controller: _eventNameController,
                cursorColor: const Color.fromARGB(255, 147, 48, 48),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 147, 48, 48)),
                  ),
                  labelText: "Event Name",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextFormField(
                controller: _locationController,
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
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromRadius(10),
                    backgroundColor: const Color.fromARGB(255, 147, 48, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(15),
                    side: const BorderSide(color: Colors.black, width: 0)),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.movie, size: 16),
                      ),
                      TextSpan(
                          text: " Pick Movie",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                onPressed: () => context.go("/search_pick_page"),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(
                widget.movie == null
                    ? "No movie selected"
                    : '${widget.movie!.title} - ${widget.movie!.year}',
                style: const TextStyle(color: Colors.white, fontSize: 24),
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
                      //Theme change needed
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
                onPressed: () async {
                  final FirebaseAuth auth = FirebaseAuth.instance;

                  await db.collection("groups").doc(currentGroupId).update({
                    'event.eventName': _eventNameController.text,
                    'event.location': _locationController.text,
                    'event.movieName': widget.movie!.title,
                    'event.startDate': _startDate.toString(),
                    'event.startTime': _startTime.toString(),
                  });

                  await db
                      .collection("users")
                      .doc(auth.currentUser!.uid)
                      .collection("groups")
                      .doc(currentGroupId)
                      .update({
                    'event.eventName': _eventNameController.text,
                    'event.location': _locationController.text,
                    'event.movieName': widget.movie!.title,
                    'event.startDate': _startDate.toString(),
                    'event.startTime': _startTime.toString(),
                  });
                  context.go("/group_page");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
