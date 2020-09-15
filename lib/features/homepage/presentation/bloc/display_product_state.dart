
import 'package:barahi/features/cart/data/cart_dto.dart';
import 'package:barahi/features/homepage/data/models/product_dto.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DisplayProductState extends Equatable {
  const DisplayProductState();

  @override
  List<Object> get props => [];
}

class DisplayProductInitialState extends DisplayProductState {}

@immutable
class DisplayProductLoadingState extends DisplayProductState {}

@immutable
class DisplayProductLoadedState extends DisplayProductState {
  final ProductDto productDto;
  final double totalPrice;
  final double discount;

  DisplayProductLoadedState({this.productDto, this.totalPrice, this.discount});

  DisplayProductLoadedState copyWith({
    List<Product> cartProducts,
    double totalPrice,
    double discount,
  }) {
    return DisplayProductLoadedState(
        totalPrice: totalPrice ?? this.totalPrice,
        discount: discount ?? this.discount);
  }

  @override
  List<Object> get props => [totalPrice, totalPrice, discount];
}

@immutable
class DisplayProductErrorState extends DisplayProductState {
   final String message;

   DisplayProductErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}