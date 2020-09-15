part of 'cart_item_bloc.dart';

abstract class CartItemEvent extends Equatable {
  const CartItemEvent();

  @override
  List<Object> get props => [];
}

@immutable
class AddProductEvent extends CartItemEvent {
  final Product product;

  AddProductEvent({this.product});
}

@immutable
class IncrementQunatityEvent extends CartItemEvent {
  final Product product;

  IncrementQunatityEvent({this.product});
}

@immutable
class DecrementQunatityEvent extends CartItemEvent {
  final Product product;

  DecrementQunatityEvent({this.product});
}

@immutable
class RemoveProductEvent extends CartItemEvent {
  final Product item;

  RemoveProductEvent({this.item});
}