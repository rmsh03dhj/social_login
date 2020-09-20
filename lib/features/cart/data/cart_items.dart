import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
@immutable
class CartItems extends Equatable {
  final Product product;
  final int quantity;

  String get totalPrice => (quantity * product.price).toStringAsFixed(2);

  CartItems({this.product, this.quantity});

  @override
  List<Object> get props => [product, quantity];
}
