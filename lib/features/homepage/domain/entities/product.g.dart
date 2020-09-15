// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    image: json['image'] as String,
    categories: (json['categories'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'categories': instance.categories,
    };
