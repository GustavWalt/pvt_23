import 'package:flutter/material.dart';
import 'package:pvt_23/screens/ChatListPage/chat_card.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

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
          title: const Text('Chatter'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: ListView(
          children: const [
            SizedBox(height: 30),
            ChatCard("Action-fantasterna"),
            ChatCard("Romantik-Gruppen"),
            ChatCard("Thriller-freaks"),
          ],
        )
    );
  }
}
