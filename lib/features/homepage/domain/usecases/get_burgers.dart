import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecase/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetBurgers implements UseCase<List<Product>, GetBurgersParams> {
  final ProductRepository productRepository;

  GetBurgers(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(GetBurgersParams params) async {
    return await productRepository.getBurgers();
  }
}

class GetBurgersParams {}
