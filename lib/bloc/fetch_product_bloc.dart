import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_dummy_app/models/product_model.dart';

import '../bloc/fetch_product_event.dart';
import '../bloc/fetch_product_state.dart';
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
        if (state.products.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        }else{
          emit(state.copyWith(
            status: ProductStatus.success,
            products: List.of(state.products)..addAll(event.products)..toSet(),
            hasReachedMax: false,
          ));
        }

        // (state.products.isEmpty)
        //     ?
        //     : emit(state.copyWith(
        //         status: ProductStatus.success,
        //         products: List.of(state.products).map((e) {
        //           if (!event.products.contains(e.documentSnapshot))
        //         }).toList()..addAll(event.products),
        //         hasReachedMax: false,
        //       ));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }
}

// class FetchProductBloc extends Bloc<FetchProductEvent, FetchProductsState> {
//   FetchProductBloc() : super(FetchProductsUnknown()) {
//     on<FetchMoreProducts>(_fetchMoreProducts);
//     on<FetchAllProducts>(_fetchAllProducts);
//     // on<FilterProducts>(_filterProducts);
//   }
//
//   Future<void> _fetchAllProducts(
//       FetchAllProducts event,
//       Emitter<FetchProductsState> state,
//       ) async {
//     // print ("updating state");
//     // final latestProducts = DatabaseRepository().fetchAllItems();
//     emit(FetchProductsInitial(products: event.products));
//   }
//
//   Future<void> _fetchMoreProducts(
//     FetchMoreProducts event,
//     Emitter<FetchProductsState> state,
//   ) async {
//     final moreProducts = DatabaseRepository()
//         .fetchAllItems(documentSnapshot: event.documentSnapshot);
//     emit(FetchProductsRequestNew(
//       products: moreProducts
//     ));
//   }
//
//
//
//   // Future<void> _filterProducts(
//   //     FilterProducts event, Emitter<FetchProductState> state) async {
//   //   // emit(FetchProductState.requestNew(
//   //   //   stream: event.stream,
//   //     // documentSnapshot: event.documentSnapshot,
//   //     // category: event.category,
//   //     // priceStart: event.priceStart,
//   //     // priceEnd: event.priceEnd,
//   //     // sortBY: event.sortBY,
//   //     // rating: event.rating,
//   //   ));
//   // }
//
//   // @override
//   // void onChange(bloc.Change<FetchProductState> change) {
//     //   super.onChange(change);
//   //   // print("state changed ${change.currentState}");
//   // }
//
// // late StreamSubscription _streamSubscription;
// // DatabaseRepository _databaseRepository;
// }
