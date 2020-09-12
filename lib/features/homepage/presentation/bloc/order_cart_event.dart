part of 'order_cart_bloc.dart';

abstract class OrderCartEvent extends Equatable {
  const OrderCartEvent();

  @override
  List<Object> get props => [];
}

@immutable
class AddProductEvent extends OrderCartEvent {
  final Product product;

  AddProductEvent({this.product});
}

@immutable
class IncrementQunatityEvent extends OrderCartEvent {
  final Product product;

  IncrementQunatityEvent({this.product});
}

@immutable
class DecrementQunatityEvent extends OrderCartEvent {
  final Product product;

  DecrementQunatityEvent({this.product});
}

@immutable
class RemoveProductEvent extends OrderCartEvent {
  final Product item;

  RemoveProductEvent({this.item});
}

@immutable
class GetAllProductEvent extends OrderCartEvent {
  final List<Product> products;

  GetAllProductEvent({this.products});
}
