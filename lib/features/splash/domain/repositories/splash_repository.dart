import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';

abstract class SplashRepository {
  Future<List<CartProductEntity>> getLocalCartProducts();
}
