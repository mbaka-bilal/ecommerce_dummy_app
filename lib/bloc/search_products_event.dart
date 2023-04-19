import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

abstract class SearchProductsEvent extends Equatable{
  const SearchProductsEvent();
}

class SearchProduct extends SearchProductsEvent{
  const SearchProduct({required this.products,required this.searchString});

  final List<ProductModel> products;
  final String searchString;

  @override
  List<Object?> get props => [products,searchString];
}