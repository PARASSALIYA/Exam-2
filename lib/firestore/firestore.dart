import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static FirestoreService firestoreService = FirestoreService._();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String notes = 'notes';

  Future<void> addNotes(String note) async {
    await _db.collection(notes).add({'notes': note});
  }

  Stream<QuerySnapshot> getNotes() {
    return _db.collection(notes).snapshots();
  }

  void deleteNotes(String id) async {
    await _db.collection(notes).doc(id).delete();
  }

  void updateNotes(String id, String note) async {
    await _db.collection(notes).doc(id).update({'notes': note});
  }
}
