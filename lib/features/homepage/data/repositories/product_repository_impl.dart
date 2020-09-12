import 'package:barahi/core/error/exceptions.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/network/network_info.dart';
import 'package:barahi/features/homepage/data/datasources/local_data_source.dart';
import 'package:barahi/features/homepage/data/datasources/remote_data_source.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl extends ProductRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {this.remoteDataSource, this.localDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final productsFromRemoteSource =
            ProductList.fromJson(products).products;
        return Right(productsFromRemoteSource);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final productsFromLocalSource = ProductList.fromJson(products).products;
        return Right(productsFromLocalSource);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(int id) async {
    throw UnimplementedError();
  }
}

final products = [
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/burger.png",
    "price": 10.45,
    "categories": [],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/1.png",
    "price": 5.0,
    "categories": [],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/2.png",
    "price": 5.0,
    "categories": [],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/3.png",
    "price": 5.0,
    "categories": [],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/4.png",
    "price": 5.0,
    "categories": [],
  },
];
