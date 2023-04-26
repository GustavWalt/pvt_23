import 'package:flutter/material.dart';

class NavigationBarProvider extends ChangeNotifier {
  int screenIndex = 0;
  int get fetchCurrentScreenIndex {
    return screenIndex;
  }

  void updateScreenIndex(int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }
}
