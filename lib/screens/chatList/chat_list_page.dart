import 'package:flutter/material.dart';
import 'package:pvt_23/screens/chatList/chat_card.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          Center(
            child: Text(
              "Chats",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          ChatCard(
            "Skogshuggarna"
          ),
          ChatCard(
            "Friskyttarna"
          ),
          ChatCard(
            "Grevens genier"
          ),
          ChatCard(
            "Flyggande getterna"
          ),
          ChatCard(
            "Multivitamin-klubben"
          ),
          ChatCard(
            "Kaffeklubben"
          ),
        ],
      )
    );
  }
}
