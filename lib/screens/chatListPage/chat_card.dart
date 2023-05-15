import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(this.cardText, {super.key});
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
      child: Column(
        mainAxisSize:MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:() {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 50),
              backgroundColor: const Color.fromARGB(255, 147, 48, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
            ),       
            child: SizedBox(
              child: Center(
                child: Text(
                  cardText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}