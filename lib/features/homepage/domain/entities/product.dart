import 'package:equatable/equatable.dart';

import 'product_category.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final double price;
  final String image;
  final List<ProductCategory> categories;

  Product({this.id, this.name, this.price, this.image, this.categories});

  @override
  List<Object> get props => [id, name, price, image, categories];

  factory Product.fromJson(Map<String, dynamic> json){

      var productCategories = json['categories'] as List;
    List<ProductCategory> categoryList = productCategories.map((i) => ProductCategory.fromJson(i)).toList();

    return new Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      categories: categoryList
    );
  }
}

class ProductList {
  final List<Product> products;

  ProductList({
    this.products,
  });

  factory ProductList.fromJson(List<dynamic> parsedJson) {

    List<Product> products = new List<Product>();
    products = parsedJson.map((i)=>Product.fromJson(i)).toList();

    return new ProductList(
        products: products
    );
  }
}



