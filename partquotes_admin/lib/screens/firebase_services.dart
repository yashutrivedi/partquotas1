import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static Future<void> addItem(
      String title, String applicableModel, String price, String description) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    return products.add({
      "Title": title,
      "Applicable Model": applicableModel,
      "price": price,
      "Description": description
    }).then((value) {
      // Data added successfully
      print("Item added successfully!");
    }).catchError((error) {
      // Error occurred while adding data
      print("Failed to add item: $error");
    });
  }

  static Future<void> updateItem(String id, String title,
      String applicableModel, String price, String description) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    return products.doc(id).update({
      "Title": title,
      "Applicable Model": applicableModel,
      "price": price,
      "Description": description
    }).then((value) {
      // Data updated successfully
      print("Item updated successfully!");
    }).catchError((error) {
      // Error occurred while updating data
      print("Failed to update item: $error");
    });
  }

  static Future<void> saveQuotationDetails(
      List<Map<String, dynamic>> quotationItems) {
    CollectionReference quotationCollection =
        FirebaseFirestore.instance.collection('quotations');

    // Add all quotation items to Firestore
    return quotationCollection.add({
      "quotationItems": quotationItems,
      "timestamp": DateTime.now(),
    }).then((value) {
      // Data added successfully
      print("Quotation details saved successfully!");
    }).catchError((error) {
      // Error occurred while adding data
      print("Failed to save quotation details: $error");
    });
  }

  static Future<void> addUserWithImage(String name, String dob, String gender,
      String mobileNo, String profileImage, String type) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.add({
        "name": name,
        "dob": dob,
        "gender": gender,
        "mobileNo": mobileNo,
        "type": type,
        "profileImage": profileImage, // Pass the base64 encoded image string
      });
      print("User added successfully!");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  static Future<dynamic> findUser(String mobileNo) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await users.where('mobileNo', isEqualTo: mobileNo).limit(1).get();

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

  static Future<void> updateCheckboxValue(String itemId, bool value) {
    CollectionReference quotationCollection = FirebaseFirestore.instance
        .collection('your_quotations_collection_name');
    return quotationCollection.doc(itemId).update({
      "isChecked": value,
    }).then((value) {
      print("Checkbox value updated successfully!");
    }).catchError((error) {
      print("Failed to update checkbox value: $error");
    });
  }
}
