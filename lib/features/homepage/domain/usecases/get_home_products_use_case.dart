import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecase/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetHomePageProductsUseCase implements UseCase<List<Product>, Params> {
  final ProductRepository productRepository;

  GetHomePageProductsUseCase(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(Params params) async {
    return await productRepository.getAllProducts();
  }
}

class Params {}
