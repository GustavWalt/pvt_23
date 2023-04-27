import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/widgets/navigation_bar_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: MenuWidget(),
      body: Center(child: Text("Hello")),
    );
  }
}
