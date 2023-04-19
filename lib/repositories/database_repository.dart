import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dummy_app/bloc/product_event.dart';
import 'package:ecommerce_dummy_app/bloc/product_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';

class DatabaseRepository {
  final _fDatabase = FirebaseFirestore.instance;
  final _fAuth = FirebaseAuth.instance;

  final _controller = StreamController<List<ProductModel>>();
  final _popularItemController = StreamController<List<ProductModel>>();
  final _searchProductsController = StreamController<List<dynamic>>();

  Stream<List<ProductModel>> get status async* {
    yield* _controller.stream;
  }

  Stream<List<ProductModel>> get popularItemStatus async* {
    yield* _popularItemController.stream;
  }

  Stream<List<dynamic>> get searchProductStatus async* {
    yield* _searchProductsController.stream;
  }

  void searchProducts(String search, [DocumentSnapshot? startAfterDocument]) {
    //TODO add pagination.
    List<ProductModel> data = [];

    if (search.trim().isEmpty) {
      _searchProductsController.add([search, data]);
      return;
    }


    try {
      if (startAfterDocument == null) {
        _fDatabase
            .collection("items")
            .where("title", isGreaterThanOrEqualTo: search)
            .where("title", isLessThan: "${search}z")
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _searchProductsController.add([search, data]);
          if (kDebugMode) {
            print("The search items are ''' 1 ''' $data");
          }
        });
      } else {
        _fDatabase
            .collection("items")
            .startAfterDocument(startAfterDocument)
            .limit(5)
            .where("title", isEqualTo: search)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _searchProductsController.add([search, data]);
          if (kDebugMode) {
            print("The search items are: $data");
          }
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  void fetchProducts([DocumentSnapshot? startAfterDocument]) {
    List<ProductModel> data = [];
    try {
      if (startAfterDocument == null) {
        _fDatabase.collection("items").limit(5).snapshots().listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _controller.add(data);
          // print("data is $data");
        });
      } else {
        _fDatabase
            .collection("items")
            .startAfterDocument(startAfterDocument)
            .limit(5)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          if (kDebugMode){
            print ("the new latest data is $data");
          }
          _controller.add(data);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  void fetchPopularProducts([DocumentSnapshot? startAfterDocument]) {
    List<ProductModel> data = [];
    try {
      if (startAfterDocument == null) {
        _fDatabase
            .collection("items")
            .limit(5)
            .where("is_popular", isEqualTo: true)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _popularItemController.add(data);
          if (kDebugMode) {
            print("The popular items are ''' 1 ''' $data");
          }
        });
      } else {
        _fDatabase
            .collection("items")
            .startAfterDocument(startAfterDocument)
            .limit(5)
            .where("is_popular", isEqualTo: true)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _popularItemController.add(data);
          if (kDebugMode) {
            print("The popular items are ''' More items ''' $data");
          }
        });
      }
    } catch (e) {
      rethrow;
    }
  }

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

        final ProductModel product = ProductModel(
          title: data["title"],
          imageUrl: data['image_url'],
          documentSnapshot: null,
        );
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
}
