import 'package:equatable/equatable.dart';

import '../models/product_model.dart';
import 'filter_product_state.dart';

abstract class FilterProductEvent extends Equatable {
}

class FilterProduct extends FilterProductEvent{
  FilterProduct({required this.products,required this.status, });

  final List<ProductModel> products;
  final FilterProductStatus status;

  @override
  List<Object?> get props => [products,status];

}