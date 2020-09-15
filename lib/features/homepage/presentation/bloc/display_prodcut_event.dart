import 'package:barahi/features/homepage/domain/entities/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DisplayProductEvent extends Equatable {
  const DisplayProductEvent();

  @override
  List<Object> get props => [];
}

@immutable
class GetAllProductEvent extends DisplayProductEvent {
  final List<Product> products;

  GetAllProductEvent({this.products});
}
