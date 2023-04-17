import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dummy_app/bloc/fetch_product_event.dart';
import 'package:ecommerce_dummy_app/bloc/fetch_product_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';

class DatabaseRepository {
  final _fDatabase = FirebaseFirestore.instance;
  final _fAuth = FirebaseAuth.instance;

  final _controller = StreamController<List<ProductModel>>();

  Stream<List<ProductModel>> get status async* {
    yield* _controller.stream;
  }

  void fetchProducts([DocumentSnapshot? startAfterDocument]) {
    List<ProductModel> data = [];
    try{
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
          _controller.add(data);
        });
      }
    }catch (e){
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

// Future<List<ProductModel>> fetchCategories() async {
//   List<ProductModel> productCategories = [];
//
//   try {
//     if (kDebugMode) {
//       print("Fetching the categories");
//     }
//     final QuerySnapshot querySnapShot =
//         await _fDatabase.collection("categories").get();
//     for (var document in querySnapShot.docs) {
//       final Map<String, dynamic> data =
//           document.data() as Map<String, dynamic>;
//
//       final ProductModel product =
//           ProductModel(title: data["title"], imageUrl: data['image_url'],);
//       productCategories.add(product);
//     }
//     if (kDebugMode) {
//       print("Sucessfully Fetch the categories $productCategories");
//     }
//     return productCategories;
//   } catch (e) {
//     if (kDebugMode) {
//       print("Error fetching the categories $e");
//     }
//     rethrow;
//   }
// }

// List<ProductModel> fetchAllItems({
//   DocumentSnapshot? documentSnapshot,
// }) {
//   List<ProductModel> data = [];
//
//   try {
//     // print ("fetching all data");
//     if (documentSnapshot == null) {
//       _fDatabase.collection("items").limit(5).snapshots().listen((event) {
//         final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
//             event.docs;
//         for (var element in snapShot) {
//           data.add(ProductModel(
//               rating: element.data()["rating"],
//               amount: element.data()["amount"],
//               title: element.data()["title"],
//               imageUrl: element.data()["image_url"]));
//         }
//         _controller.add(FetchAllProducts(data));
//         print ("data is $data");
//       });
//     } else {
//       if (kDebugMode) {
//         // print(
//         //     "fetching more items all items from database ${documentSnapshot.id}");
//       }
//       _fDatabase
//           .collection("items")
//           .orderBy("title")
//           .startAfterDocument(documentSnapshot)
//           .limit(5)
//           .snapshots()
//           .listen((event) {
//         final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
//             event.docs;
//         for (var element in snapShot) {
//           data.add(ProductModel(
//               rating: element.data()["rating"],
//               amount: element.data()["amount"],
//               title: element.data()["title"],
//               imageUrl: element.data()["image_url"]));
//         }
//       });
//     }
//     // _controller.add(FetchAllProducts());
//     return data;
//   } catch (e) {
//     if (kDebugMode) {
//       print("Error: Trying to get all items from firestore failed $e");
//     }
//     rethrow;
//   }
// }

// Stream<QuerySnapshot<Map<String, dynamic>>> fetchMoreItems({required DocumentSnapshot documentSnapshot}) {
//   try {
//     if (kDebugMode) {
//       print("fetching all items from database");
//     }
//     final stream = _fDatabase.collection("items").startAfter(
//         {documentSnapshot}).limit(5).snapshots();
//     _controller.add(FetchMoreProducts(stream: stream, documentSnapshot: documentSnapshot));
//     return stream;
//   } catch (e) {
//     if (kDebugMode) {
//       print("Error: Trying to get all items from firestore failed $e");
//     }
//     rethrow;
//   }
// }

// Stream<QuerySnapshot<Map<String, dynamic>>> fetchPopularItems() {
//   try {
//     if (kDebugMode) {
//       print("fetching popular items");
//     }
//     return _fDatabase
//         .collection("items")
//         .where("is_popular", isEqualTo: true)
//         .snapshots();
//   } catch (e) {
//     rethrow;
//   }
// }
}
