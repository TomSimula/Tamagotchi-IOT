import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference highscore = FirebaseFirestore.instance.collection('highscore');

  getScore() async{
    QuerySnapshot querySnapshot = await highscore.get();

    // Iterate through the documents in the collection
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      // Access the data of each document
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      // Use the data as needed
    }
  }
}