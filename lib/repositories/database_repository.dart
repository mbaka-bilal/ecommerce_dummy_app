import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/product_model.dart';
import '../bloc/filter_product_state.dart';

class DatabaseRepository {
  final _fDatabase = FirebaseFirestore.instance;
  final _fAuth = FirebaseAuth.instance;

  final _controller = StreamController<List<ProductModel>>();
  final _popularItemController = StreamController<List<ProductModel>>();
  final _searchProductsController = StreamController<List<dynamic>>();
  final _filterProductController = StreamController<List<dynamic>>();
  final _favoriteProductController = StreamController<List<dynamic>>();

  Stream<List<ProductModel>> get status async* {
    yield* _controller.stream;
  }

  Stream<List<ProductModel>> get popularItemStatus async* {
    yield* _popularItemController.stream;
  }

  Stream<List<dynamic>> get searchProductStatus async* {
    yield* _searchProductsController.stream;
  }

  Stream<List<dynamic>> get filterProductStream async* {
    yield* _filterProductController.stream;
  }

  Stream<List<dynamic>> get favoriteProductStream async* {
    yield* _favoriteProductController.stream;
  }

  void favoriteProducts(String id) {
    _fDatabase.collection("users").doc(id).snapshots().listen((event) {
      final Map<String, dynamic>? snapShot = event.data();
      if (snapShot!["favorites"] == null) {
        _favoriteProductController.add([]);
      } else {
        _favoriteProductController.add(snapShot["favorites"]);
      }
    });
  }

  Future<void> updateFavoriteProducts(
      List<dynamic> favorites, String id) async {
    await _fDatabase
        .collection("users")
        .doc(id)
        .update({"favorites": favorites});
  }

  void filterProduct(
      {required String collectionName,
      String? searchString,
      String? category,
      int? priceRange,
      double? rating}) {
    List<ProductModel> products = [];

    try {
      var query;

      if (searchString != null && searchString.trim().isNotEmpty) {
        query = _fDatabase
            .collection(collectionName)
            .where("title", isGreaterThanOrEqualTo: searchString)
            .where("title", isLessThan: "${searchString}z");
      } else {
        query = _fDatabase.collection(collectionName);
      }

      query.snapshots().listen((event) {
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
            event.docs;

        for (var element in snapShot) {
          final data = element.data();

          /* filter out the needed */
          /* Had to do it here because firebase does not allow multiple less than
        equal to on different fields.
         */

          if (category != null && priceRange != null && rating != null) {
            // print("all not null");
            if (data["category"] == category &&
                data["amount"] >= priceRange &&
                data["rating"] >= rating) {
              products.add(ProductModel(
                  documentID: element.id,
                  description: data["description"],
                  rating: data["rating"],
                  amount: data["amount"],
                  title: data["title"],
                  category: data["category"],
                  imageUrl: data["image_url"],
                  documentSnapshot: element));
            }
          } else if (category == null && priceRange != null && rating != null) {
            // print("only category null");
            if (data["amount"] >= priceRange && data["rating"] >= rating) {
              products.add(ProductModel(
                  documentID: element.id,
                  description: data["description"],
                  rating: data["rating"],
                  amount: data["amount"],
                  title: data["title"],
                  category: data["category"],
                  imageUrl: data["image_url"],
                  documentSnapshot: element));
            }
          } else if (category != null && priceRange == null && rating != null) {
            // print("only price range null");
            if (category == data["category"] && data["rating"] >= rating) {
              products.add(ProductModel(
                  documentID: element.id,
                  description: data["description"],
                  rating: data["rating"],
                  amount: data["amount"],
                  title: data["title"],
                  category: data["category"],
                  imageUrl: data["image_url"],
                  documentSnapshot: element));
            }
          } else if (category != null && priceRange != null && rating == null) {
            // print("only rating null");
            if (category == data["category"] && data["amount"] >= priceRange) {
              products.add(ProductModel(
                  documentID: element.id,
                  description: data["description"],
                  rating: data["rating"],
                  amount: data["amount"],
                  title: data["title"],
                  category: data["category"],
                  imageUrl: data["image_url"],
                  documentSnapshot: element));
            }
          } else if (category != null && priceRange == null && rating == null) {
            // print("only category not null");
            // print ("the data is ${element.id}");
            if (category == data["category"]) {
              // print("the data is ${data}");
              products.add(ProductModel(
                  documentID: element.id,
                  description: data["description"],
                  rating: data["rating"],
                  amount: data["amount"],
                  title: data["title"],
                  category: data["category"],
                  imageUrl: data["image_url"],
                  documentSnapshot: element));
            }
          } else if (category == null && priceRange != null && rating == null) {
            // print("only price range not null");
            if (data["amount"] >= priceRange) {
              products.add(ProductModel(
                  documentID: element.id,
                  description: data["description"],
                  rating: data["rating"],
                  amount: data["amount"],
                  title: data["title"],
                  category: data["category"],
                  imageUrl: data["image_url"],
                  documentSnapshot: element));
            }
          } else if (category == null && priceRange == null && rating != null) {
            // print("only rating not null");
            if (data["rating"] >= rating) {
              products.add(ProductModel(
                  documentID: element.id,
                  description: data["description"],
                  rating: data["rating"],
                  amount: data["amount"],
                  title: data["title"],
                  category: data["category"],
                  imageUrl: data["image_url"],
                  documentSnapshot: element));
            }
          } else {
            // print("all of them null");
            products.add(ProductModel(
                documentID: element.id,
                description: data["description"],
                rating: data["rating"],
                amount: data["amount"],
                title: data["title"],
                category: data["category"],
                imageUrl: data["image_url"],
                documentSnapshot: element));
          }
        }
        _filterProductController.add([products, FilterProductStatus.success]);
      });
    } catch (e) {
      // print("error filtering products $e");
      _filterProductController.add([[], FilterProductStatus.failed]);
    }
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
                documentID: element.id,
                description: element.data()["description"],
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _searchProductsController.add([search, data]);
          // if (kDebugMode) {
          //   print("The search items are ''' 1 ''' $data");
          // }
        });
      } else {
        _fDatabase
            .collection("items")
            .startAfterDocument(startAfterDocument)
            .limit(20)
            .where("title", isEqualTo: search)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                documentID: element.id,
                description: element.data()["description"],
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _searchProductsController.add([search, data]);
          // if (kDebugMode) {
          //   print("The search items are: $data");
          // }
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
        _fDatabase
            .collection("items")
            .orderBy("title")
            .limit(20)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                documentID: element.id,
                description: element.data()["description"],
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
        // final Map<String,dynamic> info = startAfterDocument.data() as Map<String,dynamic>;
        _fDatabase
            .collection("items")
            .orderBy("title")
            .startAfterDocument(startAfterDocument)
            // .startAfter(["${info['title']}"])
            .limit(20)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            // print("the element is ${element.id}");
            data.add(ProductModel(
                documentID: element.id,
                description: element.data()["description"],
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          // if (kDebugMode) {
          //   print("the new latest data is $data");
          // }
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
            .limit(20)
            .where("is_popular", isEqualTo: true)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                documentID: element.id,
                description: element.data()["description"],
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _popularItemController.add(data);
          // if (kDebugMode) {
          //   print("The popular items are ''' 1 ''' $data");
          // }
        });
      } else {
        _fDatabase
            .collection("items")
            .startAfterDocument(startAfterDocument)
            .limit(20)
            .where("is_popular", isEqualTo: true)
            .snapshots()
            .listen((event) {
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapShot =
              event.docs;
          for (var element in snapShot) {
            data.add(ProductModel(
                documentID: element.id,
                description: element.data()["description"],
                rating: element.data()["rating"],
                amount: element.data()["amount"],
                title: element.data()["title"],
                imageUrl: element.data()["image_url"],
                documentSnapshot: element));
          }
          _popularItemController.add(data);
          // if (kDebugMode) {
          //   print("The popular items are ''' More items ''' $data");
          // }
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUser(String firstName, String lastName) async {
    try {
      // print("adding new user to database");
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
      // if (kDebugMode) {
      //   print("Fetching the categories");
      // }
      final QuerySnapshot querySnapShot =
          await _fDatabase.collection("categories").get();
      for (var document in querySnapShot.docs) {
        final Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;

        final ProductModel product = ProductModel(
          documentID: document.id,
          title: data["title"],
          imageUrl: data['image_url'],
          documentSnapshot: null,
        );
        productCategories.add(product);
      }
      // if (kDebugMode) {
      //   print("Sucessfully Fetch the categories $productCategories");
      // }
      return productCategories;
    } catch (e) {
      // if (kDebugMode) {
      //   print("Error fetching the categories $e");
      // }
      rethrow;
    }
  }

  Future<AggregateQuerySnapshot> countDocumentsInCollection(
      {required String collectionName, String? categoryName}) async {
    try {
      final database = _fDatabase
          .collection(collectionName)
          .where("category", isEqualTo: categoryName)
          .count();
      return await database.get(source: AggregateSource.server);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createDatabaseAndTable(
      String databaseName, String tableInfo) async {
    try {
      print("creating database");
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, databaseName);

      Database database = await openDatabase(
        path,
        version: 1,
      );
      await database.execute(tableInfo);
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }

  Future<void> createTable(
      {required String databaseName, required String tableInfo}) async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    Database database = await openDatabase(path);
    await database.execute(tableInfo);
  }

  Future<bool> checkIfTableExists({required String tableName,required String databaseName}) async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    Database database = await openDatabase(path);
    List<Map<String,dynamic>> count =await database.query('sqlite_master', where: 'name = ?', whereArgs: [tableName]);

    if (count.isNotEmpty){
      return true;
    }else{
      return false;
    }

  }

  Future<void> addRecordToTable(
      {required String databaseName,
      required String tableName,
      required Map<String, dynamic> data}) async {
    try {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, databaseName);
      Database database = await openDatabase(path);

      await database.insert(tableName, data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAddressToDatabase(
      String databaseName, String address, String phoneNumber) async {
    try {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, databaseName);
      Database database = await openDatabase(path);

      await database.insert("address", {
        "name": address,
        "phone_number": phoneNumber,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchRecordFromLocalDatabase(
      String databaseName, String tableName) async {
    try {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, databaseName);
      Database database = await openDatabase(path);

      final list = await database.query(tableName);
      return list;
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> checkIfDatabaseExists(String dbName) async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);

    try {
      bool value = await databaseExists(path);

      return value;
    } catch (e) {
      rethrow;
    }
  }
}
