part of 'order_cart_bloc.dart';

abstract class OrderCartState extends Equatable {
  const OrderCartState();

  @override
  List<Object> get props => [];
}

class OrderCartInitial extends OrderCartState {}

@immutable
class OrderCartLoadingState extends OrderCartState {}

@immutable
class OrderCartLoadedState extends OrderCartState {
  final List<Product> products;
  final double totalPrice;
  final double discount;

  OrderCartLoadedState({this.products, this.totalPrice, this.discount});

  OrderCartLoadedState copyWith({
    List<Product> cartProducts,
    double totalPrice,
    double discount,
  }) {
    return OrderCartLoadedState(
        totalPrice: totalPrice ?? this.totalPrice,
        discount: discount ?? this.discount);
  }

  @override
  List<Object> get props => [totalPrice, totalPrice, discount];
}

@immutable
class OrderCartErrorState extends OrderCartState {}
