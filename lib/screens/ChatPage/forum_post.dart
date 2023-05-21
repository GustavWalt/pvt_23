import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForumPost extends StatefulWidget {
  final String cardText;
  final String groupID;
  const ForumPost(this.cardText, this.groupID, {super.key});

  @override
  State<ForumPost> createState() => _ForumPostState();
}

class _ForumPostState extends State<ForumPost> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(180, 38, 38, 100),
            width: 5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                const Icon(Icons.account_circle_rounded),
                Column(
                  children: [
                    Text(
                      widget.groupID,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 250),
                      child: Text(
                        widget.cardText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [Icon(Icons.favorite), Text("Like")],
                    ),
                    const VerticalDivider(width: 20),
                    Row(
                      children: [
                        Icon(Icons.comment),
                        TextButton(
                            onPressed: () => _commentBuilder(context),
                            child: Text("Comment"))
                      ],
                    )
                  ],
                )
              ],
            )));
  }

  Future<void> _commentBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comment'),
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
              child: const Text('Comment'),
              onPressed: () async {
                final db = FirebaseFirestore.instance;
                final FirebaseAuth auth = FirebaseAuth.instance;
                final User? currentUser = auth.currentUser;
                final uid = currentUser!.uid;

                final post = <String, dynamic>{
                  "comments": _postController.text,
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
