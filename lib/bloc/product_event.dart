import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

// abstract class FetchProductEvent {
//   const FetchProductEvent();
// }
//
// class FetchAllProducts extends FetchProductEvent {
//   const FetchAllProducts(this.products);
//
//   final List<ProductModel> products;
// }
//
// class FetchMoreProducts extends FetchProductEvent {
//   const FetchMoreProducts({
//     required this.documentSnapshot,
//   });
//
//   final DocumentSnapshot documentSnapshot;
// }
//
// class FilterProducts extends FetchProductEvent {
//   const FilterProducts(
//       {required this.stream,
//       required this.documentSnapshot,
//       this.category,
//       this.priceStart,
//       this.priceEnd,
//       this.sortBY,
//       this.rating});
//
//   final Stream stream;
//   final DocumentSnapshot documentSnapshot;
//   final String? category;
//   final int? priceStart;
//   final int? priceEnd;
//   final String? sortBY;
//   final double? rating;
// }


abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductFetched extends ProductEvent {
  ProductFetched({required this.products});

  final List<ProductModel> products;
}

