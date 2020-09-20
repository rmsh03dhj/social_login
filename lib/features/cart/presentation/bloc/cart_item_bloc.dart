import 'dart:async';

import 'package:barahi/core/error/failure.dart';
import 'package:barahi/features/cart/data/cart_dto.dart';
import 'package:barahi/features/cart/data/cart_items.dart';
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
    if (event is CartItemInitializingEvent) {
      yield CartItemLoadedState();
    }

    if (event is AddProductEvent) {
      final failureOrProduct = await addProductToCartUseCase(
          AddProductToCartParams(product: event.product));
      var state = this.state as CartItemLoadedState;

      bool itemExists = false;
      state.cartDto.selectedProducts.forEach((element) {
        if (element.product == event.product) itemExists = true;
      });

      if (itemExists) {
        yield* _eitherUpdatedQuantityOrErrorState(
            failureOrProduct, state, IncrementQuantityEvent());
      } else {
        yield* _eitherAddedOrErrorState(failureOrProduct, state);
      }
    }
    if (event is IncrementQuantityEvent) {
      final failureOrProduct = await addProductToCartUseCase(
          AddProductToCartParams(product: event.product));
      yield* _eitherUpdatedQuantityOrErrorState(failureOrProduct, state, event);
    }

    if (event is DecrementQuantityEvent) {
      final failureOrProduct = await addProductToCartUseCase(
          AddProductToCartParams(product: event.product));
      yield* _eitherUpdatedQuantityOrErrorState(failureOrProduct, state, event);
    }
    if (event is RemoveProductEvent) {
      yield* _eitherRemovedOrErrorState(event.product, state);
    }
  }

  Stream<CartItemState> _eitherAddedOrErrorState(
      Either<Failure, Product> failureOrProduct, CartItemState state) async* {
    yield failureOrProduct
        .fold((failure) => CartItemErrorState(message: "Failed"), (product) {
      if (state is CartItemLoadedState) {
        CartItems item = CartItems(product: product, quantity: 1);
        CartDto cartDto = CartDto(
            selectedProducts:
                List<CartItems>.from(state.cartDto.selectedProducts)
                  ..add(item));

        return CartItemLoadedState(cartDto: cartDto);
      } else {
        return CartItemErrorState(message: "Failed");
      }
    });
  }

  Stream<CartItemState> _eitherRemovedOrErrorState(
      Product product, CartItemState state) async* {
    if (state is CartItemLoadedState) {
      List<CartItems> updatedList =
          List<CartItems>.from(state.cartDto.selectedProducts);
      updatedList.removeWhere((element) => element.product == product);
      CartDto cartDto = CartDto(selectedProducts: updatedList);

      yield CartItemLoadedState(cartDto: cartDto);
    } else {
      yield CartItemErrorState(message: "Failed");
    }
  }

  Stream<CartItemState> _eitherUpdatedQuantityOrErrorState(
      Either<Failure, Product> failureOrProduct,
      CartItemState state,
      CartItemEvent event) async* {
    yield failureOrProduct
        .fold((failure) => CartItemErrorState(message: "Failed"), (product) {
      if (state is CartItemLoadedState) {
        int previousQuantity = 0; //default value
        int updatedQuantity = 0; //default value
        List<CartItems> lists =
            List<CartItems>.from(state.cartDto.selectedProducts);

        lists.forEach((element) {
          if (element.product == product) {
            previousQuantity = element.quantity;
          }
        });

        lists.removeWhere((element) => element.product == product);

        if (event is IncrementQuantityEvent) {
          updatedQuantity = previousQuantity + 1;
        } else {
          updatedQuantity = previousQuantity - 1;
        }

        if (updatedQuantity > 0) {
          CartItems item =
              CartItems(product: product, quantity: updatedQuantity);
          lists.add(item);
        }

        CartDto cartDto = CartDto(selectedProducts: lists);

        return CartItemLoadedState(cartDto: cartDto);
      } else {
        return CartItemErrorState(message: "Failed");
      }
    });
  }
}
