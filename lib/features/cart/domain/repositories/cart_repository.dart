import 'package:smart_catalog/features/catalog/domain/entities/cart_products_entity.dart';

abstract class CartRepository {
  Future<Map<String, CartProductEntity>?> getCartProducts();
}
