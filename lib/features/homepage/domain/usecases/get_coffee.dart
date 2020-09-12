import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecase/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetCoffee implements UseCase<List<Product>, GetCoffeeParams> {
  final ProductRepository productRepository;

  GetCoffee(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(GetCoffeeParams params) async {
    return await productRepository.getCoffee();
  }
}

class GetCoffeeParams {}
