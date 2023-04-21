import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import 'filter_product_state.dart';
import 'filter_product_event.dart';

import '../repositories/database_repository.dart';

class FilterProductBloc extends Bloc<FilterProductEvent, FilterProductState> {
  FilterProductBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(const FilterProductState()) {
    _streamSubscription =
        _databaseRepository.filterProductStream.listen((event) {
      add(FilterProduct(products: event[0], status: event[1]));
    });
    on<FilterProduct>(_filterProduct);
  }

  final DatabaseRepository _databaseRepository;
  late StreamSubscription<List<dynamic>> _streamSubscription;

  void _filterProduct(
      FilterProduct event, Emitter<FilterProductState> emitter) {
    // print ("filtering producs ${event.products}");
    if (event.status == FilterProductStatus.success) {
      emit(state.copyWith(
          status: FilterProductStatus.success, products: event.products));
    } else {
      emit(state.copyWith(status: FilterProductStatus.failed));
    }
  }
}
