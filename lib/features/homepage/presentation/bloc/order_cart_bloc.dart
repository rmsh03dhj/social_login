import 'dart:async';

import 'package:barahi/core/error/failure.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/usecases/get_burgers.dart';
import 'package:barahi/features/homepage/domain/usecases/get_coffee.dart';
import 'package:barahi/features/homepage/domain/usecases/get_desert.dart';
import 'package:barahi/features/homepage/domain/usecases/get_drinks.dart';
import 'package:barahi/features/homepage/domain/usecases/get_home_products_use_case.dart';
import 'package:barahi/features/homepage/domain/usecases/get_juice.dart';
import 'package:barahi/features/homepage/domain/usecases/get_pie.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'order_cart_event.dart';
part 'order_cart_state.dart';

class OrderCartBloc extends Bloc<OrderCartEvent, OrderCartState> {
  final GetHomePageProductsUseCase getHomePageProductsUseCase;
  final GetBurgers getBurgers;
  final GetCoffee getCoffee;
  final GetDesert getDesert;
  final GetDrinks getDrinks;
  final GetJuice getJuice;
  final GetPie getPie;

  OrderCartBloc(
      {this.getCoffee,
      this.getDesert,
      this.getJuice,
      this.getPie,
      this.getBurgers,
      this.getHomePageProductsUseCase,
      this.getDrinks})
      : super(null);

  @override
  Stream<OrderCartState> mapEventToState(OrderCartEvent event) async* {
    if (event is GetAllProductEvent) {
      yield OrderCartLoadingState();
      final failureOrTrivia =
          await getHomePageProductsUseCase(GetHomePageProductsParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    } else if (event is GetBurgersEvent) {
      yield OrderCartLoadingState();
      final failureOrTrivia = await getBurgers(GetBurgersParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    } else if (event is GetCoffeeEvent) {
      yield OrderCartLoadingState();
      final failureOrTrivia = await getCoffee(GetCoffeeParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    } else if (event is GetDesertEvent) {
      yield OrderCartLoadingState();
      final failureOrTrivia = await getDesert(GetDesertParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    } else if (event is GetDrinksEvent) {
      yield OrderCartLoadingState();
      final failureOrTrivia = await getDrinks(GetDrinkParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    } else if (event is GetPiesEvent) {
      yield OrderCartLoadingState();
      final failureOrTrivia = await getPie(GetPieParams());
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
