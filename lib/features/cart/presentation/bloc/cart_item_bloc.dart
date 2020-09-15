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
      yield CartItemLoadingState();
      final failureOrProduct =
          await addProductToCartUseCase(AddProductToCartParams(product: event.product));
      yield* _eitherLoadedOrErrorState(failureOrProduct, state);
    }
  }

  Stream<CartItemState> _eitherLoadedOrErrorState(
      Either<Failure, Product> failureOrProduct, CartItemState state) async* {

    yield failureOrProduct
        .fold((failure) => CartItemErrorState(message: "Failed"), (product) {

          if(state is CartItemLoadedState){
            print(List.from(state.cartDto.selectedProducts));
            CartDto cartDto = CartDto(selectedProducts : List.from(state.cartDto.selectedProducts..add(product)));

            return CartItemLoadedState(cartDto: cartDto);
          }else{
            return CartItemErrorState(message: "Failed");
          }

    });
  }
}
