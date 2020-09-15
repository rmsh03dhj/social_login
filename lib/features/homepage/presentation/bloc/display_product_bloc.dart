import 'dart:async';

import 'package:barahi/core/error/failure.dart';
import 'package:barahi/features/homepage/data/models/product_dto.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:barahi/features/homepage/domain/usecases/get_home_page_products_use_case.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_prodcut_event.dart';
import 'package:barahi/features/homepage/presentation/bloc/display_product_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class DisplayProductBloc extends Bloc<DisplayProductEvent, DisplayProductState> {
  final GetHomePageProductsUseCase getHomePageProductsUseCase;
  final AddProductToCartUseCase addProductToCartUseCase;

  DisplayProductBloc({this.getHomePageProductsUseCase,this.addProductToCartUseCase}) : super(null);

  @override
  Stream<DisplayProductState> mapEventToState(DisplayProductEvent event) async* {
    if (event is GetAllProductEvent) {
      yield DisplayProductLoadingState();
      final failureOrProductDto =
          await getHomePageProductsUseCase(GetHomePageProductsParams());
      yield* _eitherLoadedOrErrorState(failureOrProductDto);
    }
  }

  Stream<DisplayProductState> _eitherLoadedOrErrorState(
      Either<Failure, List<Product>> failureOrProducts) async* {
    yield failureOrProducts
        .fold((failure) => DisplayProductErrorState(message: "Failed"), (products) {
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

      return DisplayProductLoadedState(productDto: productDto);
    });
  }
}
