import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final _firestore = FirebaseFirestore.instance;

  instaDetailAdd(String username, String password) async {
    await _firestore.collection('InstaIds').doc().set({
      'username': username,
      'password': password,
    });
  }
}
