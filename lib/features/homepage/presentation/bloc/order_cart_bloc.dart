import 'dart:async';

import 'package:barahi/core/error/failure.dart';
import 'package:barahi/features/homepage/data/models/product_dto.dart';
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
      final failureOrTrivia =
          await getHomePageProductsUseCase(GetHomePageProductsParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<OrderCartState> _eitherLoadedOrErrorState(
      Either<Failure, List<Product>> failureOrProducts) async* {
    yield failureOrProducts
        .fold((failure) => OrderCartErrorState(message: "Failed"), (products) {
      List<Product> burgers =
          products.where((product) => product.categories.contains("burger")).toList();
      List<Product> popularProducts =
          products.where((product) => product.categories.contains("popular")).toList();
      List<Product> coffee =
          products.where((product) => product.categories.contains("coffee")).toList();
      List<Product> desert =
          products.where((product) => product.categories.contains("desert")).toList();
      List<Product> drinks =
          products.where((product) => product.categories.contains("drink")).toList();
      List<Product> juice =
          products.where((product) => product.categories.contains("juice")).toList();
      List<Product> pies =
          products.where((product) => product.categories.contains("pie")).toList();

      ProductDto productDto = ProductDto()
        ..allProducts = products
        ..popularProducts = popularProducts
        ..burgers = burgers
        ..coffees = coffee
        ..deserts = desert
        ..drinks = drinks
        ..juices = juice
        ..pies = pies;

      return OrderCartLoadedState(productDto: productDto);
    });
  }
}
