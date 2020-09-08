part of 'order_bloc.dart';

@immutable
abstract class OrderEvent extends Equatable{
  OrderEvent([List props = const []]) : super(props);
}

class CartItem extends OrderEvent {
  final OrderedItem item;
  CartItem(this.item) : super([item]);
}

class DeleteItem extends OrderEvent {
  final OrderedItem item;
  DeleteItem(this.item) : super([item]);
}

class UpdateOrder extends OrderEvent {
  final OrderedItem item;
  UpdateOrder(this.item) : super([item]);
}