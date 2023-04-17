import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

enum ProductStatus { initial, success, failure }

class ProductState extends Equatable {
  const ProductState(
      {this.status = ProductStatus.initial,
        this.products = const <ProductModel>[],
        this.maxReached = false});

  final ProductStatus status;
  final List<ProductModel> products;
  final bool maxReached;

  ProductState copyWith(
      {ProductStatus? status,
      List<ProductModel>? products,
      bool? hasReachedMax}) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      maxReached: hasReachedMax ?? maxReached,
    );
  }

  @override
  List<Object?> get props => [status, products, maxReached];
}

// class FetchProductsState extends Equatable {
//   FetchProductsState({this.latestProducts, this.popularProducts});
//
//   set updateLatestProduct(List<ProductModel> products) {
//     latestProducts = products;
//   }
//
//   set updatePopularProducts(List<ProductModel> products) {
//     popularProducts = products;
//   }
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [latestProducts, popularProducts];
//
//   List<ProductModel>? latestProducts;
//   List<ProductModel>? popularProducts;
// }
//
// class FetchProductsUnknown extends FetchProductsState {
//
// }
//
// class FetchProductsInitial extends FetchProductsState {
//   FetchProductsInitial({required this.products}) {
//     print ("doint stuff in state");
//     final List<ProductModel>? superList = super.latestProducts;
//     if (superList != null) {
//       superList.addAll(products);
//       super.updateLatestProduct = superList;
//       print ("the list is $superList");
//     }else{
//       super.updateLatestProduct = products;
//       print ("the list is $products");
//     }
//   }
//
//   final List<ProductModel> products;
// }
//
// class FetchProductsRequestNew extends FetchProductsState {
//   FetchProductsRequestNew({required this.products}) {
//     final List<ProductModel>? superList = super.latestProducts;
//     if (superList != null) {
//       superList.addAll(products);
//       updateLatestProduct = superList;
//     }
//   }
//
//   final List<ProductModel> products;
// }

// class FetchProductState extends Equatable {
//   const FetchProductState._({this.latestProducts, this.popularProducts});
//
//   const FetchProductState.unKnown() : this._();
//
//   const FetchProductState.initialState({required List<ProductModel> products})
//       : this._(
//           latestProducts: products,
//         );
//
//   const FetchProductState.requestNew({required List<ProductModel> products})
//       : this._(latestProducts: products);
//
//   final List<ProductModel>? latestProducts;
//   final List<ProductModel>? popularProducts;
//
//   @override
//   List<Object?> get props => [latestProducts, popularProducts];
// }
