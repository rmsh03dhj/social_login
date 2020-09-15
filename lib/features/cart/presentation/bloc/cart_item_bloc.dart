import 'dart:async';

import 'package:barahi/core/error/failure.dart';
import 'package:barahi/features/cart/data/cart_dto.dart';
import 'package:barahi/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cart_item_event.dart';
part 'cart_item_state.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  final AddProductToCartUseCase addProductToCartUseCase;

  CartItemBloc({this.addProductToCartUseCase}) : super(null);

  @override
  Stream<CartItemState> mapEventToState(CartItemEvent event) async* {

    if (event is AddProductEvent) {
      print("adding product");
      yield CartItemLoadingState();
      final failureOrProduct =
          await addProductToCartUseCase(AddProductToCartParams(product: event.product));
      yield* _eitherLoadedOrErrorState(failureOrProduct);
    }
  }

  Stream<CartItemState> _eitherLoadedOrErrorState(
      Either<Failure, Product> failureOrProduct) async* {
    List<Product> selectedProducts = List();
    double totalPrice = 0.0;
    yield failureOrProduct
        .fold((failure) => CartItemErrorState(message: "Failed"), (product) {
      selectedProducts.add(product);
          totalPrice+=product.price;

      CartDto cartDto = CartDto()
        ..selectedProducts = selectedProducts
        ..totalPrice = totalPrice;

      return CartItemLoadedState(cartDto: cartDto);
    });
  }
}
