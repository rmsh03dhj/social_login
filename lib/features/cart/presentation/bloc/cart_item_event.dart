part of 'cart_item_bloc.dart';

abstract class CartItemEvent extends Equatable {
  const CartItemEvent();

  @override
  List<Object> get props => [];
}

@immutable
class CartItemInitializingEvent extends CartItemEvent {
  CartItemInitializingEvent();
}

@immutable
class AddProductEvent extends CartItemEvent {
  final Product product;

  AddProductEvent({this.product});
}

@immutable
class IncrementQuantityEvent extends CartItemEvent {
  final Product product;

  IncrementQuantityEvent({this.product});
}

@immutable
class DecrementQuantityEvent extends CartItemEvent {
  final Product product;

  DecrementQuantityEvent({this.product});
}

@immutable
class RemoveProductEvent extends CartItemEvent {
  final Product item;

  RemoveProductEvent({this.item});
}