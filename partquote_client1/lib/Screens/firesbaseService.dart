import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static findUser(String mobileno) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await users.where('mobileNo', isEqualTo: mobileno).limit(1).get();

    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      // Document found, you can access it here
      var doc = querySnapshot.docs.first;
      return doc;
    } else {
      // No documents found matching the query
      return "not found";
    }
  }
}
