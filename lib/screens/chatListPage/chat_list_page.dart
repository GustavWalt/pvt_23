import 'package:flutter/material.dart';
import 'package:pvt_23/screens/chatListPage/chat_card.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MenuWidget(),
        body: ListView(
          children: const [
            Center(
              child: Text(
                "Chats",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            ChatCard("Skogshuggarna"),
            ChatCard("Friskyttarna"),
            ChatCard("Grevens genier"),
            ChatCard("Flyggande getterna"),
            ChatCard("Multivitamin-klubben"),
            ChatCard("Kaffeklubben"),
          ],
        ));
  }
}
