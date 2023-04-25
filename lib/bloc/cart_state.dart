import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  CartItem({
    required this.itemName,
    this.itemNumber = 1,
    required this.imageUrl,
    required this.amount,
  });

  final String itemName;
  int itemNumber;
  final String imageUrl;
  final int amount;

  CartItem copyWith(
      {String? itemName, int? itemNumber, String? imageUrl, int? amount}) {
    return CartItem(
      itemName: itemName ?? this.itemName,
      imageUrl: imageUrl ?? this.imageUrl,
      amount: amount ?? this.amount,
      itemNumber: itemNumber ?? this.itemNumber,
    );
  }

  @override
  List<Object?> get props => [itemName, itemNumber, imageUrl, amount];
}

class CartState extends Equatable {
  const CartState({
    this.items = const <CartItem>[],
    this.totalCost = 0,
    this.totalItems = 0,
  });

  final List<CartItem> items;
  final int totalItems;
  final int totalCost;

  CartState copyWith(
      {required List<CartItem>? items,
      required int? totalItems,
      required int? totalCost}) {
    return CartState(
        items: items ?? this.items,
        totalCost: totalCost ?? this.totalCost,
        totalItems: totalItems ?? this.totalItems);
  }

  @override
  List<Object?> get props => [items,totalItems,totalCost];
}
