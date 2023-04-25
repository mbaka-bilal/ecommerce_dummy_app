import 'package:bloc/bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ///Manage the cart state
  ///
  CartBloc() : super(const CartState()) {
    on<CartInitial>(_cartInitial);
    on<CartAdd>(_addToCart);
    on<CartRemove>(_removeFromCart);
    on<CartDelete>(_deleteFromCart);
  }

  void _cartInitial(CartInitial event, Emitter<CartState> emit) {
    emit(state.copyWith(items: [], totalItems: null, totalCost: null));
  }

  void _addToCart(CartAdd event, Emitter<CartState> emit) {
    ///Add item to cart
    List<CartItem> items = List.of(state.items);
    for (var i = 0; i < items.length; i++) {
      var element = items[i];
      if (element.itemName == event.item.itemName) {
        // this because bloc only checks if the memory address of two objects are the same
        // to decide if they are the same, so i needed to copy the element out, and
        // re-add it to the list so that bloc will register that the list has changed
        // ChatGPT.
        var newElement = element.copyWith(itemNumber: element.itemNumber + 1);
        items[i] = newElement;

        emit(state.copyWith(
            items: List.of(items),
            totalItems: state.totalItems + 1,
            totalCost: state.totalCost + element.amount));
        return;
      }
    }
    List<CartItem> list = [...state.items];
    list.add(event.item);

    emit(state.copyWith(
        items: [...list],
        totalCost: state.totalCost + event.item.amount,
        totalItems: state.totalItems + 1));
  }

  void _removeFromCart(CartRemove event, Emitter<CartState> emit) {
    List<CartItem> items = List.of(state.items);
    for (var i = 0; i < items.length; i++) {
      var element = items[i];
      if (element.itemName == event.item.itemName) {

        if (element.itemNumber == 1){
          // if there is only 1 item left in the cart, remove it from the cart
          add(CartDelete(item: element));
          return;
        }

        //Check _addToCart for reason for this.
        var newElement = element.copyWith(itemNumber: element.itemNumber - 1);
        items[i] = newElement;

        emit(state.copyWith(
            items: List.of(items),
            totalItems: state.totalItems - 1,
            totalCost: state.totalCost - element.amount));
        return;
      }
    }
    // emit(state.copyWith(
        // items: List.of(state.items)..add(event.item),
        // totalItems: null,
        // totalCost: null));
  }

  void _deleteFromCart(CartDelete event, Emitter<CartState> emit) {
    List<CartItem> items = List.of(state.items);

    for (var i = 0; i < items.length; i++){
      var element = items[i];

      if (element.itemName == event.item.itemName) {
        state.items.remove(element);
        emit(state.copyWith(items: List.of(state.items),
            totalItems: state.totalItems - element.itemNumber,
            totalCost: state.totalCost - (element.amount * element.itemNumber)));
        return;
      }


    }
  }
}
