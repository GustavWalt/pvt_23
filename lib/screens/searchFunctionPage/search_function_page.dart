import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';


class SearchFunctionPage extends StatelessWidget {
  const SearchFunctionPage({Key? key}) : super(key: key);

  @override
  _SearchFunctionPageState createState() => _GroupPageState();
}

class _SearchFunctionPageState extends State<SearchFunctionPage>
String valueChoose;
List listItems = [
"Action", "Adventure", "Comedy", "Family", "Romance", "Thriller"
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MenuWidget(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Search',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                            height: 80,
                            padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                            child: DropdownButton(
                              value: valueChoose,
                              onChanged: (newValue),
                              valueChoose
                              hint: Text("Genre"),
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                          );
                      },
                    ),

                : Container(),
            Container(
                height: 65,
                padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromRadius(80),
                      backgroundColor: Colors.black),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.add, size: 16),
                        ),
                        TextSpan(text: "Find groups"),
                      ],
                    ),
                  ),
                  //Shuold not go to group page, this is placeholder. Should go to available groups.
                  onPressed: () => context.go('/group_page'),
                )),
          ],        )
        )
      );
  }
}