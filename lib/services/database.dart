import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference highscore = FirebaseFirestore.instance.collection('highscore');

  Stream<QuerySnapshot> getScore() {
    return highscore.snapshots();
  }

  putScore(String name, int score) {
    highscore.add({
      'name': name,
      'score': score,
    });
  }
}