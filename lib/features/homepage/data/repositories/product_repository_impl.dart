import 'package:barahi/core/error/exceptions.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/network/network_info.dart';
import 'package:barahi/features/homepage/data/datasources/local_data_source.dart';
import 'package:barahi/features/homepage/data/datasources/remote_data_source.dart';
import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:barahi/features/homepage/domain/entities/product_list.dart';
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
  Future<Either<Failure, List<Product>>> getBurgers() async {
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
        productsFromLocalSource
            .where((item) => item.categories.contains("burger"));
        return Right(productsFromLocalSource);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCoffee() async {
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
        productsFromLocalSource
            .where((item) => item.categories.contains("coffee"));
        return Right(productsFromLocalSource);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getDesert() async {
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
        productsFromLocalSource
            .where((item) => item.categories.contains("desert"));
        return Right(productsFromLocalSource);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getDrinks() async {
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
        productsFromLocalSource
            .where((item) => item.categories.contains("drinks"));
        return Right(productsFromLocalSource);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getJuice() async {
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
        productsFromLocalSource
            .where((item) => item.categories.contains("juice"));
        return Right(productsFromLocalSource);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getPie() async {
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
        productsFromLocalSource
            .where((item) => item.categories.contains("pie"));
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
  ///burgers
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/burger/1.png",
    "price": 10.45,
    "categories": ["burger"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/burger/2.png",
    "price": 5.0,
    "categories": ["burger"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/burger/3.png",
    "price": 5.0,
    "categories": ["burger"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/burger/4.png",
    "price": 5.0,
    "categories": ["burger"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/burger/5.png",
    "price": 5.0,
    "categories": ["burger"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/burger/6.png",
    "price": 5.0,
    "categories": ["burger"],
  },

  ///coffee
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/1.png",
    "price": 10.45,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/2.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/3.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/4.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/5.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/6.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/7.png",
    "price": 10.45,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/8.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/9.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/10.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/11.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/coffee/12.png",
    "price": 5.0,
    "categories": ["coffee"],
  },

  ///desert
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/1.png",
    "price": 10.45,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/2.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/3.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/4.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/5.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/6.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/7.png",
    "price": 10.45,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/8.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/9.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/desert/10.png",
    "price": 5.0,
    "categories": ["desert"],
  },

  ///hard drinks
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/1.png",
    "price": 10.45,
    "categories": ["hard_drink"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/2.png",
    "price": 5.0,
    "categories": ["hard_drink"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/3.png",
    "price": 5.0,
    "categories": ["hard_drink"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/4.png",
    "price": 5.0,
    "categories": ["hard_drink"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/5.png",
    "price": 5.0,
    "categories": ["hard_drink"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/6.png",
    "price": 5.0,
    "categories": ["hard_drink"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/7.png",
    "price": 10.45,
    "categories": ["hard_drink"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/8.png",
    "price": 5.0,
    "categories": ["hard_drink"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/drinks/9.png",
    "price": 5.0,
    "categories": ["hard_drink"],
  },

  ///juice
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/1.png",
    "price": 10.45,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/2.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/3.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/4.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/5.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/6.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/7.png",
    "price": 10.45,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/8.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/9.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/10.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/11.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/juice/12.png",
    "price": 5.0,
    "categories": ["juice"],
  },

  ///pies
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/1.png",
    "price": 10.45,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/2.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/3.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/4.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/5.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/6.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/7.png",
    "price": 10.45,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/8.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/9.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/10.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": 1,
    "name": "Chicken Burger",
    "image": "assets/pies/11.png",
    "price": 5.0,
    "categories": ["pie"],
  },
];
