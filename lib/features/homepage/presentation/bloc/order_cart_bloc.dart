import 'dart:async';

import 'package:barahi/core/error/failure.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/usecases/get_home_products_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'order_cart_event.dart';
part 'order_cart_state.dart';

class OrderCartBloc extends Bloc<OrderCartEvent, OrderCartState> {
  final GetHomePageProductsUseCase getHomePageProductsUseCase;

  OrderCartBloc({this.getHomePageProductsUseCase}) : super(null);

  @override
  Stream<OrderCartState> mapEventToState(OrderCartEvent event) async* {
    if (event is GetAllProductEvent) {
      yield OrderCartLoadingState();
      final failureOrTrivia = await getHomePageProductsUseCase(Params());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<OrderCartState> _eitherLoadedOrErrorState(
      Either<Failure, List<Product>> failureOrProducts) async* {
    yield failureOrProducts.fold(
      (failure) => OrderCartErrorState(message: "Failed"),
      (products) => OrderCartLoadedState(products: products),
    );
  }
}
