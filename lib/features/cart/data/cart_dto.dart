import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CartDto extends Equatable {
  const CartDto({this.selectedProducts = const <Product>[]});

  final List<Product> selectedProducts;

  double get totalPrice =>
      selectedProducts.fold(0, (total, current) => total + current.price);

  @override
  List<Object> get props => [selectedProducts];
}
