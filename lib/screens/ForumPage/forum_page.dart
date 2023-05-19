import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/screens/ForumPage/forum_post.dart';
import 'package:intl/intl.dart';
import '../../providers/group_id_provider.dart';
import '../../widgets/navigation_bar_widget.dart';

class ForumPage extends StatefulWidget {
  Stream<QuerySnapshot<Map<String, dynamic>>>? selectedGroup;
  ForumPage({super.key, this.selectedGroup});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final TextEditingController _postController = TextEditingController();

  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final Stream<QuerySnapshot> _groupsStream =
      FirebaseFirestore.instance.collection('groups').snapshots();

  @override
  Widget build(BuildContext context) {
    final groupIdProvider = Provider.of<GroupIdProvider>(context);
    String currentGroupId = groupIdProvider.fetchCurrentGroupId;

    String _formatDateTime(int millisecondsSinceEpoch) {
      final dateTime =
          DateTime.fromMicrosecondsSinceEpoch(millisecondsSinceEpoch);
      final formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: widget.selectedGroup,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (currentGroupId != snapshot.data!.docs[0].id) {
            groupIdProvider.updateGroupId(snapshot.data!.docs[0].id);
          }
        });

        return Scaffold(
          bottomNavigationBar: const MenuWidget(),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Create new post', // used by assistive technologies
            onPressed: () => _dialogBuilder(context, currentGroupId),
            child: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(180, 38, 38, 100),
          ),
          appBar: AppBar(
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      context.go("/profile_page");
                    },
                    child: Icon(Icons.account_circle),
                  ))
            ],
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.go("/chat_list_page");
                  },
                );
              },
            ),
            title: const Text('Forum'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              List posts = data["posts"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: posts.reversed.map((post) {
                  final User? currentUser = auth.currentUser;
                  if (post.containsKey("likes")) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(post['uid'])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error fetching full name');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Fetching full name...');
                        }

                        String? fullName = (snapshot.data!.data()
                            as Map<String, dynamic>)['fullname'];
                        return ListTile(
                          leading: Icon(Icons.account_circle_rounded),
                          title: Text(fullName ?? ''),
                          subtitle: Text("${post['msg']}"),
                          trailing:
                              Text("${_formatDateTime(post['createdOn'])}"),
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                }).toList(),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context, String currentGroupId) {
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
                final User? currentUser = auth.currentUser;
                final uid = currentUser!.uid;

                final post = <String, dynamic>{
                  "likes": 0,
                  "msg": _postController.text,
                  "uid": uid,
                  'createdOn': DateTime.now().microsecondsSinceEpoch
                };

                DocumentReference roomRef =
                    db.collection("groups").doc(currentGroupId);

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
