import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FilterOptions extends Equatable{
  const FilterOptions({this.category,
    this.price, this.rating});


  final String? category;
  final int? price;
  final double? rating;

  @override
  List<Object?> get props => [category,price,rating];
}

class FilterOptionsBloc extends Cubit<FilterOptions> {
  FilterOptionsBloc() : super(const FilterOptions());

  // FilterOptions _filterOptions = const FilterOptions();

  // void fetchState(){
  //   emit (_filterOptions);
  // }

  void updateState({String? category,int? price,double? rating }){
    emit(FilterOptions(category: category,price: price,rating: rating));
    // _filterOptions = FilterOptions(category: category,price: price,rating: rating);
  }

  void resetState(){
    emit(const FilterOptions());
  }
}