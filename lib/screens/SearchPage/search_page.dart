import 'dart:convert';
import 'package:flutter/src/material/range_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

const List<String> listGenres = <String>[
  "Action",
  "Adventure",
  "Comedy",
  "Romance"
];

const List<String> listSubGenres = <String>["1", "2", "3", "4", "5"];

const List<String> listDecades = <String>[
  "50s",
  "60s",
  "70s",
  "80s",
  "90s",
  "00s",
  "2010s",
  "2020s"
];

const List<String> listStreamproviders = <String>[
  "Cmore",
  "HBO",
  "Netflix",
  "Hulu",
  "Viaplay"
];

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchBarController = TextEditingController();
  Object? valueChoose;

  String genreValue = listGenres.first;
  String subGenreValue = listSubGenres.first;
  String decadeValue = listDecades.first;
  String streamProviderValue = listStreamproviders.first;

  RangeValues values = const RangeValues(0, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MenuWidget(),
      backgroundColor: const Color.fromARGB(255, 35, 33, 26),
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
        title: const Text('Search movies'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(60, 40, 60, 0),
            child: TextField(
              controller: _searchBarController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search for movie",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(color: Colors.black, width: 2))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 40, 60, 15),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: DropdownButtonFormField(
                hint: const Text("Genres"),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 25,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 17),
                onChanged: (String? newValue) {
                  setState(() {
                    genreValue = newValue!;
                  });
                },
                items: listGenres.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: DropdownButtonFormField(
                hint: const Text("Sub-genre"),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 25,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 17),
                onChanged: (String? newValue) {
                  setState(() {
                    subGenreValue = newValue!;
                  });
                },
                items: listSubGenres.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: DropdownButtonFormField(
                hint: const Text("Decade"),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 25,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 17),
                onChanged: (String? newValue) {
                  setState(() {
                    decadeValue = newValue!;
                  });
                },
                items: listDecades.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 15, 60, 40),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: DropdownButtonFormField(
                hint: const Text("Streaming provider"),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 25,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 17),
                onChanged: (String? newValue) {
                  setState(() {
                    streamProviderValue = newValue!;
                  });
                },
                items: listStreamproviders.map((String valueItem) {
                  return DropdownMenuItem<String>(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "Rating: 0-10",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 40),
            child: RangeSlider(
              values: values,
              min: 0,
              max: 10,
              divisions: 10,
              activeColor: const Color.fromARGB(255, 147, 48, 48),
              inactiveColor: Colors.grey,
              labels: RangeLabels(
                values.start.round().toString(),
                values.end.round().toString(),
              ),
              onChanged: (values) => setState(() => this.values = values),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromRadius(10),
                    backgroundColor: const Color.fromARGB(255, 147, 48, 48),
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
                          text: "Show results",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                onPressed: () => context.go('/search_results_page'),
              ))
        ],
      ),
    );
  }
}
