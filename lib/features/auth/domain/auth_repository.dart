import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_catalog/core/domain/entities/product_entity.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';

abstract class AuthRepository {
  Future<UserCredential> login(String email, String password);
  Future<Map<String, ProductEntity>?> getCartProducts();
  Future<void> saveLocalCartProducts(List<ProductEntity> products);
  Future<void> saveLocalOrders(Map<String, OrderEntity> orders);
  Future<List<OrderEntity>> getOrders();
  Future<List<String>> getCatalogImages();
  Future<void> forgotPassword(String email);
}
