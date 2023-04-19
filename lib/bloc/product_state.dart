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

