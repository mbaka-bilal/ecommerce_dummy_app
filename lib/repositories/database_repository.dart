import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';

class DatabaseRepository {
  final _fDatabase = FirebaseFirestore.instance;
  final _fAuth = FirebaseAuth.instance;

  Future<void> createUser(String firstName, String lastName) async {
    try {
      print("adding new user to database");
      await _fDatabase.collection("users").doc(_fAuth.currentUser!.uid).set({
        "first_name": firstName,
        "last_name": lastName,
        "created_at": Timestamp.now()
      });
      // return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchCategories() async {
    List<ProductModel> productCategories = [];

    try {
      if (kDebugMode) {
        print("Fetching the categories");
      }
      final QuerySnapshot querySnapShot =
          await _fDatabase.collection("categories").get();
      for (var document in querySnapShot.docs) {
        final Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;

        final ProductModel product =
            ProductModel(title: data["title"], imageUrl: data['image_url']);
        productCategories.add(product);
      }
      if (kDebugMode) {
        print("Sucessfully Fetch the categories $productCategories");
      }
      return productCategories;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching the categories $e");
      }
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllItems() {
    try {
      if (kDebugMode) {
        print("fetching all items from database");
      }
      return _fDatabase.collection("items").snapshots();
    } catch (e) {
      if (kDebugMode) {
        print("Error: Trying to get all items from firestore failed $e");
      }
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPopularItems() {
    try {
      if (kDebugMode) {
        print("fetching popular items");
      }
      return _fDatabase
          .collection("items")
          .where("is_popular", isEqualTo: true)
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }
}
