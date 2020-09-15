part of 'cart_item_bloc.dart';

abstract class CartItemState extends Equatable {
  const CartItemState();

  @override
  List<Object> get props => [];
}

class CartItemInitialState extends CartItemState {}

@immutable
class CartItemLoadingState extends CartItemState {}

@immutable
class CartItemLoadedState extends CartItemState {
  final CartDto cartDto;

  CartItemLoadedState({this.cartDto});

  CartItemLoadedState copyWith({CartDto cartDto}) {
    return CartItemLoadedState(cartDto: cartDto ?? this.cartDto);
  }

  @override
  List<Object> get props => [cartDto];
}

@immutable
class CartItemErrorState extends CartItemState {
  final String message;

  CartItemErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
