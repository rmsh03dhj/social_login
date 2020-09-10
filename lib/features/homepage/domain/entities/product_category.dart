import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  final int id;
  final String name;
  final String icon;

  ProductCategory({this.id, this.name, this.icon});

  @override
  List<Object> get props => [id, name, icon];

   factory ProductCategory.fromJson(Map<String, dynamic> json){

    return new ProductCategory(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}