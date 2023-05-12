import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvt_23/screens/ForumPage/forum_post.dart';
import '../../widgets/navigation_bar_widget.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Create new post', // used by assistive technologies
          onPressed: () => _dialogBuilder(context),
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(180, 38, 38, 100),
        ),
        backgroundColor: const Color.fromRGBO(45, 45, 45, 100),
        bottomNavigationBar: const MenuWidget(),
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.account_circle_rounded),
            )
          ],
          leading: const Icon(Icons.arrow_back_rounded),
          title: const Text('Forum'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Column(
                children: [ForumPost("test card", "Hello")],
              ),
            ],
          ),
        ));
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create post'),
          content: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _postController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Content',
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Post'),
              onPressed: () async {
                final db = FirebaseFirestore.instance;
                final FirebaseAuth auth = FirebaseAuth.instance;
                final User? currentUser = auth.currentUser;
                final uid = currentUser!.uid;

                final post = <String, dynamic>{
                  "likes": 0,
                  "msg": _postController.text,
                  "uid": uid,
                  'createdOn': DateTime.now().microsecondsSinceEpoch
                };

                DocumentReference roomRef =
                    db.collection("groups").doc("4V6nCMzVFvgjxxEeT84i");

                roomRef.update({
                  "posts": FieldValue.arrayUnion([post]),
                });

                Navigator.of(context).pop();
                _postController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
