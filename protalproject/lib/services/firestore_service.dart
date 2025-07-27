import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> createClass(String title, String link) async {
    await _db.collection('classes').add({
      'title': title,
      'link': link,
      'createdAt': Timestamp.now(),
    });
  }
}
