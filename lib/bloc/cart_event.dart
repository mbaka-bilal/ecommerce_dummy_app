import 'package:equatable/equatable.dart';

import 'cart_state.dart';



abstract class CartEvent extends Equatable {
  // const CartEvent({this.item = const <CartItem>[]});
  //
  // final List<CartItem> item;
}

class CartInitial extends CartEvent {
  @override
  List<Object?> get props => [];
}

class CartAdd extends CartEvent {
  CartAdd({required this.item});

  final CartItem item;

  @override
  List<Object?> get props => [item];
}

class CartDelete extends CartEvent {
  CartDelete({required this.item});

  final CartItem item;

  @override
  List<Object?> get props => [item];
}

class CartRemove extends CartEvent {
  CartRemove({required this.item});

  final CartItem item;

  @override
  List<Object?> get props => [item];
}
