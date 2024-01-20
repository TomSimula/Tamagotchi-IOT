import 'package:cloud_firestore/cloud_firestore.dart';

class Score {
  String name;
  int score;

  Score(this.name, this.score);

  // a factory method to create a score from a corresponding Firestore document
  factory Score.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return Score(data!['name'], data!['score']);
  }
}