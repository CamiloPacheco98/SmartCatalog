import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';

abstract class SplashRepository {
  Future<List<CartProductEntity>> getLocalCartProducts();
  Future<void> saveLocalCartProducts(List<CartProductEntity> products);
  Future<void> saveAppSettings(String key, bool value);
  Future<bool> getAppSettings(String key, {bool defaultValue = false});
  Future<Map<String, CartProductEntity>?> getCartProducts();
}
