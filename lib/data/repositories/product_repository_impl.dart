
import 'package:barahi/domain/entities/product.dart';
import 'package:barahi/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<Product>> getAllProducts() async{
      return ProductList.fromJson(products).products;   
  }

  @override
  Future<Product> getProduct(int id) async{
    throw UnimplementedError();
  }
}

final products = 
  [
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
    },    {
      "id": 1,
      "name": "Chicken Burger",
      "image": "assets/2.png",
      "price": 5.0,
      "categories": [],
    },    {
      "id": 1,
      "name": "Chicken Burger",
      "image": "assets/3.png",
      "price": 5.0,
      "categories": [],
    },    {
      "id": 1,
      "name": "Chicken Burger",
      "image": "assets/4.png",
      "price": 5.0,
      "categories": [],
    }, 
  ];
