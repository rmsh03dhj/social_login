import 'dart:async';

import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'order_cart_event.dart';
part 'order_cart_state.dart';

class OrderCartBloc extends Bloc<OrderCartEvent, OrderCartState> {
  final AddProductToCartUseCase addProductToCartUseCase;
  
  OrderCartBloc() : 
  addProductToCartUseCase = sl(),
  super(OrderCartInitial());

  @override
  Stream<OrderCartState> mapEventToState(OrderCartEvent event) async* {
    if (event is OrderCartEvent) {
      if (state is OrderCartLoadedState) {
        final cartResults = await addProductToCartUseCase.buildUseCaseStream(AddToCartUseCaseParams());        
        yield OrderCartLoadedState(
          products: cartResults.products,  
        );
      } else if (state is CartLoadedState) {
        yield state;
      }
    } 
  }
}
