import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecase/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetPie implements UseCase<List<Product>, GetPieParams> {
  final ProductRepository productRepository;

  GetPie(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(GetPieParams params) async {
    return await productRepository.getPie();
  }
}

class GetPieParams {}
