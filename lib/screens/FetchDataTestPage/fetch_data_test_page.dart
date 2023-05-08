import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class FetchDataTestPage extends StatefulWidget {
  const FetchDataTestPage({Key? key}) : super(key: key);
  @override
  _FetchDataTestPageState createState() => _FetchDataTestPageState();
}

class _FetchDataTestPageState extends State<FetchDataTestPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Scaffold(
          bottomNavigationBar: const MenuWidget(),
          body: ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['fullname']),
                    subtitle: Text(data['uid']),
                  );
                })
                .toList()
                .cast(),
          ),
        );
      },
    );
  }
}
