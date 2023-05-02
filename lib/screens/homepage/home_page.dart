import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  Map<String, dynamic>? _userData = null;

  Future<void> getUserData() async {
    final docRef = db.collection("users").doc(user!.uid);
    var data = null;
    docRef.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error getting document: $e"),
    );

    setState(() {
      _userData = data;
    });
    developer.log(data as String);
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Scaffold(
        body: Center(
      child: Text("Hello World"),
    ));
  }
}
