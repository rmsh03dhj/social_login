import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'cart_items.dart';

@immutable
class CartDto extends Equatable {
  const CartDto({this.selectedProducts = const <CartItems>[]});

  final List<CartItems> selectedProducts;


  double get totalPrice =>
      selectedProducts.fold(0, (total, current) => total + (current.product.price*current.quantity));

  @override
  List<Object> get props => [selectedProducts];
}
