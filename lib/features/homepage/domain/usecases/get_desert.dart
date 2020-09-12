import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecase/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetDesert implements UseCase<List<Product>, GetDesertParams> {
  final ProductRepository productRepository;

  GetDesert(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(GetDesertParams params) async {
    return await productRepository.getDesert();
  }
}

class GetDesertParams {}
