import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:smart_catalog/core/data/models/cart_product_model.dart';
import 'package:smart_catalog/core/data/models/order_model.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:hive/hive.dart';

class CartRepositoryImpl extends CartRepository {
  final Box<Map> _cartBox;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CartRepositoryImpl({
    required Box<Map> cartBox,
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _cartBox = cartBox,
       _firestore = firestore,
       _auth = auth;

  @override
  Future<void> increaseQuantityLocalAt(int index) async {
    final productMap = _cartBox.getAt(index);
    if (productMap == null) return;
    final productJson = Map<String, dynamic>.from(productMap);
    final product = CartProductModel.fromJson(productJson);
    final updatedProduct = product.copyWith(quantity: product.quantity + 1);
    await _cartBox.putAt(index, updatedProduct.toJson());
  }

  @override
  Future<void> decreaseQuantityLocalAt(int index) async {
    final productMap = _cartBox.getAt(index);
    if (productMap == null) return;
    final productJson = Map<String, dynamic>.from(productMap);
    final product = CartProductModel.fromJson(productJson);
    final updatedProduct = product.copyWith(quantity: product.quantity - 1);
    await _cartBox.putAt(index, updatedProduct.toJson());
  }

  @override
  Future<void> increaseQuantity(String productId) async {
    final user = _auth.currentUser;
    if (user == null) return debugPrint('User not found');
    await _firestore.collection(FirestoreCollections.cart).doc(user.uid).update(
      {'$productId.quantity': FieldValue.increment(1)},
    );
  }

  @override
  Future<void> decreaseQuantity(String productId) async {
    final user = _auth.currentUser;
    if (user == null) return debugPrint('User not found');
    await _firestore.collection(FirestoreCollections.cart).doc(user.uid).update(
      {'$productId.quantity': FieldValue.increment(-1)},
    );
  }

  @override
  Future<void> deleteProductLocalAt(int index) async {
    await _cartBox.deleteAt(index);
  }

  @override
  Future<void> deleteProduct(String productId) async {
    final user = _auth.currentUser;
    if (user == null) return debugPrint('User not found');
    await _firestore.collection(FirestoreCollections.cart).doc(user.uid).update(
      {productId: FieldValue.delete()},
    );
  }

  @override
  Future<void> deleteAllProducts() async {
    final user = _auth.currentUser;
    if (user == null) return debugPrint('User not found');
    await _firestore
        .collection(FirestoreCollections.cart)
        .doc(user.uid)
        .delete();
  }

  @override
  Future<void> deleteAllProductsLocal() async {
    await _cartBox.clear();
  }

  @override
  Future<void> makeOrder(OrderEntity order) async {
    final user = _auth.currentUser;
    if (user == null) return debugPrint('User not found');
    final orderModel = OrderModel.fromEntity(order);
    await _firestore.collection(FirestoreCollections.orders).doc(user.uid).set({
      order.id: orderModel.toJson(),
    }, SetOptions(merge: true));
  }
}
