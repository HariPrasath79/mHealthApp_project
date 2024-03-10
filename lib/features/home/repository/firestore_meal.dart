import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHome {
  static Future<Map<String, dynamic>> fetchMeal(String id) async {
    final docRef = await FirebaseFirestore.instance
        .collection('meal_collection')
        .doc(id)
        .get();

    final doc = docRef.data() as Map<String, dynamic>;
    return doc;
  }
}
