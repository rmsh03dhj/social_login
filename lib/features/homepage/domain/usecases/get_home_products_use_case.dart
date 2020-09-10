import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/usecases/usecase.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/service_locator.dart';
import 'package:dartz/dartz.dart';


    
class GetHomePageProductsUseCase implements UseCase<List<Product>, HomeProductParams>  {

  @override
  Future<Either<Failure,List<Product>>> call(
      HomeProductParams params) async {

  }
}
class HomeProductParams {}

class HomeProductsResult extends UseCaseResult {
  final List<Product> salesProducts;
  final List<Product> newProducts;

  HomeProductsResult({this.salesProducts, this.newProducts, Exception exception, bool result})
    : super(exception: exception, result: result);
}

class HomeProductsException implements Exception {}