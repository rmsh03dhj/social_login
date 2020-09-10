

import 'package:barahi/core/error/failure.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct(int id);
  Future<Either<Failure, List<Product>>> getAllProducts();
}