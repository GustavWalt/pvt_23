import 'package:flutter/material.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: MenuWidget(),
      body: Center(child: Text("HOMEPAGE")),
    );
  }
}
