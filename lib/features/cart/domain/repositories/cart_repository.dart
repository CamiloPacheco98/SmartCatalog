import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';

abstract class CartRepository {
  Future<Map<String, CartProductEntity>?> getCartProducts();
}
