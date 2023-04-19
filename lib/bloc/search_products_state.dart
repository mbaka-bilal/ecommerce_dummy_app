import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

enum SearchProductsEnum {
  initial,
  success,
  failed,
}

class SearchProductState extends Equatable {
  const SearchProductState({
    this.status = SearchProductsEnum.initial,
    this.products = const <ProductModel>[],
    this.maxReached = false,
    this.searchString = "",
  });

  final SearchProductsEnum status;
  final List<ProductModel> products;
  final bool maxReached;
  final String searchString;

  @override
  List<Object?> get props => [status, products, maxReached,searchString];

  SearchProductState copyWith({
    SearchProductsEnum? status,
    List<ProductModel>? products,
    bool? maxReached,
    String? searchString,
  }) {
    return SearchProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      maxReached: maxReached ?? this.maxReached,
      searchString: searchString ?? this.searchString,
    );
  }
}
