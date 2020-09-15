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
  Future<Either<Failure, Product>> getProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final productsFromRemoteSource =
            ProductList.fromJson(products).products;
        Product outputProduct = Product();
        for (Product prod in productsFromRemoteSource) {
          if (product.id.compareTo(prod.id)==0) {
            outputProduct = prod;
            break;
          }
        }
        return Right(outputProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final productsFromLocalSource = ProductList.fromJson(products).products;
        Product outputProduct = Product();
        for (Product prod in productsFromLocalSource) {
          if (prod.id == id) {
            outputProduct = prod;
            break;
          }
        }
        return Right(outputProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

final products = [
  ///burgers
  {
    "id": "1_1",
    "name": "Chicken Burger",
    "image": "assets/burger/1.png",
    "price": 10.45,
    "categories": ["burger"],
  },
  {
    "id": "1_2",
    "name": "Beef Burger",
    "image": "assets/burger/2.png",
    "price": 5.0,
    "categories": ["burger"],
  },
  {
    "id": "1_3",
    "name": "Double Chicken Burger",
    "image": "assets/burger/3.png",
    "price": 5.0,
    "categories": ["burger"],
  },
  {
    "id": "1_4",
    "name": "Burger with Dragon Fruit",
    "image": "assets/burger/4.png",
    "price": 5.0,
    "categories": ["burger"],
  },
  {
    "id": "1_5",
    "name": "Basa Burger",
    "image": "assets/burger/5.png",
    "price": 5.0,
    "categories": ["burger"],
  },
  {
    "id": "1_6",
    "name": "Pork Burger",
    "image": "assets/burger/6.png",
    "price": 5.0,
    "categories": ["burger", "popular"],
  },

  ///coffee
  {
    "id": "2_1",
    "name": "Espresso",
    "image": "assets/coffee/1.png",
    "price": 10.45,
    "categories": ["coffee"],
  },
  {
    "id": "2_2",
    "name": "Double Espresso",
    "image": "assets/coffee/2.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_3",
    "name": "Red Eye",
    "image": "assets/coffee/3.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_4",
    "name": "Black Eye",
    "image": "assets/coffee/4.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_5",
    "name": "Americano",
    "image": "assets/coffee/5.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_6",
    "name": "Long Black",
    "image": "assets/coffee/6.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_7",
    "name": "Macchiato",
    "image": "assets/coffee/7.png",
    "price": 10.45,
    "categories": ["coffee", "popular"],
  },
  {
    "id": "2_8",
    "name": "Long Macchiato",
    "image": "assets/coffee/8.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_9",
    "name": "Cortado",
    "image": "assets/coffee/9.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_10",
    "name": "Breve",
    "image": "assets/coffee/10.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_11",
    "name": "Cappuccino",
    "image": "assets/coffee/11.png",
    "price": 5.0,
    "categories": ["coffee"],
  },
  {
    "id": "2_12",
    "name": "Flat White",
    "image": "assets/coffee/12.png",
    "price": 5.0,
    "categories": ["coffee"],
  },

  ///desert
  {
    "id": "3_1",
    "name": "Chicken Burger",
    "image": "assets/desert/1.png",
    "price": 10.45,
    "categories": ["desert"],
  },
  {
    "id": "3_2",
    "name": "Chicken Burger",
    "image": "assets/desert/2.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": "3_3",
    "name": "Chicken Burger",
    "image": "assets/desert/3.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": "3_4",
    "name": "Chicken Burger",
    "image": "assets/desert/4.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": "3_5",
    "name": "Chicken Burger",
    "image": "assets/desert/5.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": "3_6",
    "name": "Chicken Burger",
    "image": "assets/desert/6.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": "3_7",
    "name": "Chicken Burger",
    "image": "assets/desert/7.png",
    "price": 10.45,
    "categories": ["desert"],
  },
  {
    "id": "3_8",
    "name": "Chicken Burger",
    "image": "assets/desert/8.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": "3_9",
    "name": "Chicken Burger",
    "image": "assets/desert/9.png",
    "price": 5.0,
    "categories": ["desert"],
  },
  {
    "id": "3_10",
    "name": "Chicken Burger",
    "image": "assets/desert/10.png",
    "price": 5.0,
    "categories": ["desert"],
  },

  ///drinks
  {
    "id": "4_1",
    "name": "Chicken Burger",
    "image": "assets/drinks/1.png",
    "price": 10.45,
    "categories": ["drink"],
  },
  {
    "id": "4_2",
    "name": "Chicken Burger",
    "image": "assets/drinks/2.png",
    "price": 5.0,
    "categories": ["drink", "popular"],
  },
  {
    "id": "4_3",
    "name": "Chicken Burger",
    "image": "assets/drinks/3.png",
    "price": 5.0,
    "categories": ["drink"],
  },
  {
    "id": "4_4",
    "name": "Chicken Burger",
    "image": "assets/drinks/4.png",
    "price": 5.0,
    "categories": ["drink"],
  },
  {
    "id": "4_5",
    "name": "Chicken Burger",
    "image": "assets/drinks/5.png",
    "price": 5.0,
    "categories": ["drink"],
  },
  {
    "id": "4_6",
    "name": "Chicken Burger",
    "image": "assets/drinks/6.png",
    "price": 5.0,
    "categories": ["drink"],
  },
  {
    "id": "4_7",
    "name": "Chicken Burger",
    "image": "assets/drinks/7.png",
    "price": 10.45,
    "categories": ["drink"],
  },
  {
    "id": "4_8",
    "name": "Chicken Burger",
    "image": "assets/drinks/8.png",
    "price": 5.0,
    "categories": ["drink"],
  },
  {
    "id": "4_9",
    "name": "Chicken Burger",
    "image": "assets/drinks/9.png",
    "price": 5.0,
    "categories": ["drink"],
  },

  ///juice
  {
    "id": "5_1",
    "name": "Chicken Burger",
    "image": "assets/juice/1.png",
    "price": 10.45,
    "categories": ["juice"],
  },
  {
    "id": "5_2",
    "name": "Chicken Burger",
    "image": "assets/juice/2.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_3",
    "name": "Chicken Burger",
    "image": "assets/juice/3.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_4",
    "name": "Chicken Burger",
    "image": "assets/juice/4.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_5",
    "name": "Chicken Burger",
    "image": "assets/juice/5.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_6",
    "name": "Chicken Burger",
    "image": "assets/juice/6.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_7",
    "name": "Chicken Burger",
    "image": "assets/juice/7.png",
    "price": 10.45,
    "categories": ["juice"],
  },
  {
    "id": "5_8",
    "name": "Chicken Burger",
    "image": "assets/juice/8.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_9",
    "name": "Chicken Burger",
    "image": "assets/juice/9.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_10",
    "name": "Chicken Burger",
    "image": "assets/juice/10.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_11",
    "name": "Chicken Burger",
    "image": "assets/juice/11.png",
    "price": 5.0,
    "categories": ["juice"],
  },
  {
    "id": "5_12",
    "name": "Chicken Burger",
    "image": "assets/juice/12.png",
    "price": 5.0,
    "categories": ["juice"],
  },

  ///pies
  {
    "id": "6_1",
    "name": "Chicken Burger",
    "image": "assets/pies/1.png",
    "price": 10.45,
    "categories": ["pie"],
  },
  {
    "id": "6_2",
    "name": "Chicken Burger",
    "image": "assets/pies/2.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": "6_3",
    "name": "Chicken Burger",
    "image": "assets/pies/3.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": "6_4",
    "name": "Chicken Burger",
    "image": "assets/pies/4.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": "6_5",
    "name": "Chicken Burger",
    "image": "assets/pies/5.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": "6_7",
    "name": "Chicken Burger",
    "image": "assets/pies/6.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": "6_8",
    "name": "Chicken Burger",
    "image": "assets/pies/7.png",
    "price": 10.45,
    "categories": ["pie"],
  },
  {
    "id": "6_9",
    "name": "Chicken Burger",
    "image": "assets/pies/8.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": "6_10",
    "name": "Chicken Burger",
    "image": "assets/pies/9.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": "6_11",
    "name": "Chicken Burger",
    "image": "assets/pies/10.png",
    "price": 5.0,
    "categories": ["pie"],
  },
  {
    "id": "6_12",
    "name": "Chicken Burger",
    "image": "assets/pies/11.png",
    "price": 5.0,
    "categories": ["pie"],
  },
];
