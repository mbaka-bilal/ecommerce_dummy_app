import 'package:ecommerce_dummy_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

enum FilterProductStatus {
  initial,
  loading,
  success,
  failed,
}

class FilterProductState extends Equatable {
  const FilterProductState({
    this.products = const <ProductModel>[],
    this.status = FilterProductStatus.initial,
  });

  final List<ProductModel> products;
  final FilterProductStatus status;

  FilterProductState copyWith({
    List<ProductModel>? products,
    FilterProductStatus? status,
  }) {
    return FilterProductState(
        products: products ?? this.products, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [products, status];
}
