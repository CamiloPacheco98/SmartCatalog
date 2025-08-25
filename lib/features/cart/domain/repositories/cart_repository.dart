import 'package:smart_catalog/core/domain/entities/order_entity.dart';

abstract class CartRepository {
  Future<void> increaseQuantityLocalAt(int index);
  Future<void> decreaseQuantityLocalAt(int index);
  Future<void> increaseQuantity(String productId);
  Future<void> decreaseQuantity(String productId);
  Future<void> deleteProductLocalAt(int index);
  Future<void> deleteProduct(String productId);
  Future<void> deleteAllProducts();
  Future<void> deleteAllProductsLocal();
  Future<void> makeOrder(OrderEntity order);
}
