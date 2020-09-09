import 'dart:async';

import 'package:barahi/data/repositories/product_repository_impl.dart';
import 'package:barahi/domain/entities/product.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddProductToCartUseCase
    extends UseCase<AddToCartUseCaseResponse, AddToCartUseCaseParams> {
  final ProductRepositoryImpl productRepositoryImpl;

  AddProductToCartUseCase(this.productRepositoryImpl);

  @override
  Future<Stream<AddToCartUseCaseResponse>> buildUseCaseStream(
      AddToCartUseCaseParams params) async {
    final controller = StreamController<AddToCartUseCaseResponse>();
    try {
      final products = await productRepositoryImpl.getAllProducts();
      controller.add(AddToCartUseCaseResponse(products));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class AddToCartUseCaseParams {
  AddToCartUseCaseParams();
}

class AddToCartUseCaseResponse {
  final List<Product> products;

  AddToCartUseCaseResponse(this.products);
}
