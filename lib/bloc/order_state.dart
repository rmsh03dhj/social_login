part of 'order_bloc.dart';

@immutable
abstract class OrderState extends Equatable{
  OrderState([List props = const []]) : super(props);
}

class OrderInitial extends OrderState {}

class ErrorOrder extends OrderState {
  final String message;

  ErrorOrder(this.message);

}

class ItemAdded extends OrderState {
  final List<OrderedItem> items;

  ItemAdded(this.items) : super([items]);
}