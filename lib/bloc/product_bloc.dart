import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../models/product_model.dart';
import '../repositories/database_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(const ProductState()) {
    _streamSubscription = _databaseRepository.status.listen((event) {
      add(ProductFetched(products: event));
    });
    on<ProductFetched>(_onProductFetched);
  }

  final DatabaseRepository _databaseRepository;
  late StreamSubscription<List<ProductModel>> _streamSubscription;

  Future<void> _onProductFetched(
      ProductFetched event, Emitter<ProductState> emit) async {
    if (state.maxReached) return;

    try {
      if (state.status == ProductStatus.initial) {
        return emit(state.copyWith(
          status: ProductStatus.success,
          products: event.products,
          hasReachedMax: false,
        ));
      } else {
        if (event.products.isEmpty) {
          // if (kDebugMode){
          //   print ("latest products has reached maximum");
          // }
          emit(state.copyWith(hasReachedMax: true));
        } else {
          // if (kDebugMode){
          //   print ("adding to latest products");
          // }
          emit(state.copyWith(
            status: ProductStatus.success,
            products: List.of(state.products)
              ..addAll(event.products)
              ,
            hasReachedMax: false,
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }
}
