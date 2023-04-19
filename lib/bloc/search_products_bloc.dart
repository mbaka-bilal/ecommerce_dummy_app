import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc/search_products_event.dart';
import '../bloc/search_products_state.dart';
import '../repositories/database_repository.dart';

class SearchProductBloc extends Bloc<SearchProductsEvent, SearchProductState> {
  SearchProductBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,

        super(const SearchProductState()) {
    _streamSubscription = _databaseRepository.searchProductStatus.listen((event) {
      add(SearchProduct(searchString: event.first,products: event.last));
    });
    on<SearchProduct>(_searchProduct);
  }

  final DatabaseRepository _databaseRepository;
  late StreamSubscription<List<dynamic>> _streamSubscription;

  void _searchProduct(
      SearchProduct event, Emitter<SearchProductState> emitter) {
    // if (state.maxReached) return;

    try {
      if (state.status == SearchProductsEnum.initial) {
        return emit(state.copyWith(
          searchString: event.searchString,
          status: SearchProductsEnum.success,
          products: event.products,
          maxReached: false,
        ));
      } else {
          print ("the documents are ${event.products}");
          emit(state.copyWith(
            searchString: event.searchString,
            status: SearchProductsEnum.success,
            products: event.products,
            maxReached: false,
          ));

      }
    } catch (e) {
      print ("error fetching search ${e}");
      emit(state.copyWith(status: SearchProductsEnum.failed));
    }
  }
}
