import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import '../repositories/database_repository.dart';

import 'popular_products_event.dart';
import 'popular_products_state.dart';

class PopularProductsBloc
    extends Bloc<PopularProductsEvent, PopularProductState> {
  PopularProductsBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(const PopularProductState()) {
    _streamSubscription = _databaseRepository.popularItemStatus.listen((event) {
      add(PopularProductFetched(popularProducts: event));
    });
    on<PopularProductFetched>(_onPopularProductFetched);
  }

  final DatabaseRepository _databaseRepository;
  late StreamSubscription<List<ProductModel>> _streamSubscription;

  void _onPopularProductFetched(
      PopularProductFetched event, Emitter<PopularProductState> emit) {
    if (state.maxReached) return;

    try {
      if (state.status == PopularProductStatus.initial) {
        return emit(state.copyWith(
          status: PopularProductStatus.success,
          popularProducts: event.popularProducts,
          maxReached: false,
        ));
      } else {
        if (state.popularProducts.isEmpty) {
          emit(state.copyWith(maxReached: true));
        } else {
          emit(state.copyWith(
            status: PopularProductStatus.success,
            popularProducts: List.of(state.popularProducts)
              ..addAll(event.popularProducts)
              ..toSet(),
            maxReached: false,
          ));
        }
      }
    } catch (e) {
      if (kDebugMode){
        print ("Error!!! fetching popular products reason: $e");
      }
      emit(state.copyWith(status: PopularProductStatus.failure));
    }
  }
}
