import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/navigation_bar_widget.dart';

//We need to add genres - either manually or through imdb's API.
const List<String> genres = <String>['Horror', 'Comedy', 'Sci-fi'];
const List<String> level = <String>["1", "2", "3"];

class FindGroupPage extends StatefulWidget {
  const FindGroupPage({super.key});

  @override
  State<FindGroupPage> createState() => _FindGroupPageState();
}

class _FindGroupPageState extends State<FindGroupPage> {
  String genreValue = genres.first;
  String levelValue = level.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MenuWidget(),
        backgroundColor: Color.fromARGB(255, 35, 33, 26),
        appBar: AppBar(
          title: const Text('Find groups'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: <Widget>[
          const Padding(padding: EdgeInsets.all(10)),
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Pick a genre",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white))),
          DecoratedBox(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 163, 4, 4),
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                  ]),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                  child: DropdownButton<String>(
                    value: genreValue,
                    dropdownColor: Colors.black,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    elevation: 8,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String? value) {
                      setState(() {
                        genreValue = value!;
                      });
                    },
                    items: genres.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ))),
          const Padding(padding: EdgeInsets.all(10)),
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Pick a discussion level",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white))),
          DecoratedBox(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 163, 4, 4),
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                  ]),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                  child: DropdownButton<String>(
                    value: levelValue,
                    dropdownColor: Colors.black,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    elevation: 8,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String? value) {
                      setState(() {
                        levelValue = value!;
                      });
                    },
                    items: level.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ))),
          const Padding(
            padding: EdgeInsets.all(70),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromRadius(10),
                    backgroundColor: const Color.fromARGB(255, 163, 4, 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(20),
                    side: const BorderSide(color: Colors.black, width: 3)),

                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.add, size: 16),
                      ),
                      TextSpan(
                          text: "Find groups",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                //Shuold not go to group page, this is placeholder. Should go to available groups.
                onPressed: () => context.go('/group_page'),
              ))
        ])));
  }
}
