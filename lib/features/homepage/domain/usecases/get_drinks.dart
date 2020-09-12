import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecase/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetDrinks implements UseCase<List<Product>, GetDrinkParams> {
  final ProductRepository productRepository;

  GetDrinks(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(GetDrinkParams params) async {
    return await productRepository.getDrinks();
  }
}

class GetDrinkParams {}
