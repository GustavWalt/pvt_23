import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        title: const Text('Forums'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30),
          ChatCard("Action-fantasterna"),
          ChatCard("Romantik-Gruppen"),
          ChatCard("Thriller-freaks"),
          SizedBox(height: 120),
          Center(
            child: Container(
              height: 170.0,
              width: 210.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/undraw_Chat.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
