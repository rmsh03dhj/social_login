
import 'package:barahi/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Product> getProduct(int id);
  Future<List<Product>> getAllProducts();
}