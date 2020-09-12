import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecase/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetJuice implements UseCase<List<Product>, GetJuiceParams> {
  final ProductRepository productRepository;

  GetJuice(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(GetJuiceParams params) async {
    return await productRepository.getJuice();
  }
}

class GetJuiceParams {}
