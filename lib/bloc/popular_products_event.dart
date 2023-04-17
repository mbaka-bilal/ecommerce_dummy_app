import 'package:equatable/equatable.dart';

import '/models/product_model.dart';

abstract class PopularProductsEvent extends Equatable {
  const PopularProductsEvent();

  @override
  List<Object> get props => [];
}

class PopularProductFetched extends PopularProductsEvent {
  const PopularProductFetched({required this.popularProducts});

  final List<ProductModel> popularProducts;
}
