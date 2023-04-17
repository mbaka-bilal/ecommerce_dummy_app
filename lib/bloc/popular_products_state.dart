import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

enum PopularProductStatus { initial, success, failure }

class PopularProductState extends Equatable {
  const PopularProductState(
      {this.status = PopularProductStatus.initial,
      this.popularProducts = const <ProductModel>[],
      this.maxReached = false});

  final PopularProductStatus status;
  final List<ProductModel> popularProducts;
  final bool maxReached;

  PopularProductState copyWith(
      {PopularProductStatus? status,
      List<ProductModel>? popularProducts,
      bool? maxReached}) {
    return PopularProductState(
      status: status ?? this.status,
      popularProducts: popularProducts ?? this.popularProducts,
      maxReached: maxReached ?? this.maxReached,
    );
  }

  @override
  List<Object?> get props => [status, popularProducts, maxReached];
}
