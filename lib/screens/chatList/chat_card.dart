import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(this.cardText, {super.key});
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(
              child: Text(
                cardText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}