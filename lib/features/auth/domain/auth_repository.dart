import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';

abstract class AuthRepository {
  Future<UserCredential> login(String email, String password);
  Future<Map<String, CartProductEntity>?> getCartProducts();
  Future<void> saveLocalCartProducts(List<CartProductEntity> products);
  Future<void> saveLocalOrders(Map<String, OrderEntity> orders);
  Future<List<OrderEntity>> getOrders();
}
