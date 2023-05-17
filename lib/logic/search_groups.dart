import 'package:cloud_firestore/cloud_firestore.dart';

class SearchGroup {
  String genreValue = "";
  String levelValue = "";
  String sizeValue = "";

  Stream<QuerySnapshot<Map<String, dynamic>>> findGroups() {
    final CollectionReference groups =
        FirebaseFirestore.instance.collection('groups');
    final Stream<QuerySnapshot<Map<String, dynamic>>> matchingGroups =
        FirebaseFirestore.instance
            .collection('groups')
            .where('genre', isEqualTo: genreValue.toString())
            .where('size', isEqualTo: sizeValue.toString())
            .where('level', isEqualTo: levelValue.toString())
            .snapshots();

    return matchingGroups;
  }

  void setValues(String genre, String size, String level) {
    genreValue = genre;
    sizeValue = size;
    levelValue = level;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatch() {
    return findGroups();
  }
}
