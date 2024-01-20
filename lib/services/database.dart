import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamagotchi/modele/score.dart';

class DatabaseService {
  final CollectionReference highscore = FirebaseFirestore.instance.collection('highscore');

  Stream<List<Score>> getScore() {
    return highscore.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Score.fromFirestore(doc)).toList());
  }

  addScore(String name, int score) {
    highscore.add({
      'name': name,
      'score': score,
    });
  }
}