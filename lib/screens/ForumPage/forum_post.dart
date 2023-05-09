import 'package:flutter/material.dart';

class ForumPost extends StatelessWidget {
  const ForumPost(this.groupID, this.cardText, {super.key});
  final String cardText;
  final String groupID;

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
                      groupID,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 250),
                      child: Text(
                        cardText,
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
                      children: const [Icon(Icons.comment), Text("Comment")],
                    )
                  ],
                )
              ],
            )));
  }
}
