import 'package:flutter/material.dart';

class GroupIdProvider extends ChangeNotifier {
  String groupID = "";
  String get fetchCurrentGroupId {
    return groupID;
  }

  void updateGroupId(String newGroupId) {
    groupID = newGroupId;
    notifyListeners();
  }
}
