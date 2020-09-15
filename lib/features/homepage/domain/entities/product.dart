import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String id;
  final String name;
  final double price;
  final String image;
  final List<String> categories;

  Product({this.id, this.name, this.price, this.image, this.categories});

  @override
  List<Object> get props => [id, name, price, image, categories];

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}



