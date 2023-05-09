import 'package:flutter/material.dart';
import 'package:pvt_23/screens/ForumPage/forum_post.dart';
import '../../widgets/navigation_bar_widget.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const FloatingActionButton(
          tooltip: 'Create new post', // used by assistive technologies
          onPressed: null,
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
}
