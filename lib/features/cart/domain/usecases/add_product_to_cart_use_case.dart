import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecase/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AddProductToCartUseCase implements UseCase<Product, AddProductToCartParams> {
  final ProductRepository productRepository;

  AddProductToCartUseCase(this.productRepository);

  @override
  Future<Either<Failure, Product>> call(AddProductToCartParams params) async {
    print("I am herer ${params.product.name}");
        return await productRepository.getProduct(params.product);
  }
}

class AddProductToCartParams extends Equatable {
  final Product product;

  AddProductToCartParams({@required this.product});

  @override
  List<Object> get props => [product];
}
