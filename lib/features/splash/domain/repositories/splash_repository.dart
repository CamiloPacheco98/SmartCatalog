import 'package:smart_catalog/core/domain/entities/product_entity.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';

abstract class SplashRepository {
  Future<List<ProductEntity>> getLocalCartProducts();
  Future<void> saveLocalCartProducts(List<ProductEntity> products);
  Future<void> saveAppSettings(String key, bool value);
  Future<bool> getAppSettings(String key, {bool defaultValue = false});
  Future<Map<String, ProductEntity>?> getCartProducts();
  Future<void> saveLocalOrders(Map<String, OrderEntity> orders);
  Future<List<OrderEntity>> getLocalOrders();
  Future<List<OrderEntity>> getOrders();
}
