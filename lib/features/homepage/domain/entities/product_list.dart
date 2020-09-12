

import 'package:barahi/features/homepage/domain/entities/product.dart';

class ProductList {
  final List<Product> products;

  ProductList({this.products});

  factory ProductList.fromJson(List<dynamic> parsedJson) {

    List<Product> products = new List<Product>();
    products = parsedJson.map((i)=>Product.fromJson(i)).toList();

    return new ProductList(
        products: products
    );
  }

}