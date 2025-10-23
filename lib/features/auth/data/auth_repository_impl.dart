import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:smart_catalog/core/data/models/order_model.dart';
import 'package:smart_catalog/core/data/models/product_model.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/core/domain/entities/product_entity.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Box<Map> _cartBox;
  final Box<Map> _ordersBox;
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  AuthRepositoryImpl({
    required Box<Map> cartBox,
    required Box<Map> ordersBox,
    required FirebaseAuth auth,
    required FirebaseFirestore db,
  }) : _cartBox = cartBox,
       _ordersBox = ordersBox,
       _auth = auth,
       _db = db;

  @override
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<Map<String, ProductEntity>?> getCartProducts() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    final products = await _db
        .collection(FirestoreCollections.cart)
        .doc(uid)
        .get()
        .then((value) => value.data());
    if (products == null) return {};
    return products.map(
      (key, value) => MapEntry(key, ProductModel.fromJson(value).toEntity()),
    );
  }

  @override
  Future<void> saveLocalCartProducts(List<ProductEntity> products) async {
    final productListJson = products
        .map((e) => ProductModel.fromEntity(e).toJson())
        .toList();
    await _cartBox.addAll(productListJson);
  }

  @override
  Future<void> saveLocalOrders(Map<String, OrderEntity> orders) async {
    final orderListJson = orders.map(
      (key, value) => MapEntry(key, OrderModel.fromEntity(value).toJson()),
    );
    await _ordersBox.putAll(orderListJson);
  }

  @override
  Future<List<OrderEntity>> getOrders() async {
    if (_auth.currentUser == null) throw Exception("User not logged in");
    final orders = await _db
        .collection(FirestoreCollections.orders)
        .doc(_auth.currentUser?.uid)
        .get()
        .then((value) => value.data());
    if (orders == null) return [];
    return orders.values.map((e) => OrderModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<List<String>> getCatalogImages() async {
    try {
      if (_auth.currentUser == null) throw Exception("User not logged in");

      final catalogInfo = await _db
          .collection(FirestoreCollections.catalog)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get()
          .then((value) => value.docs);

      if (catalogInfo.isEmpty) return [];

      // Assuming the catalog documents have an 'images' field with a list of image URLs
      final lastCatalogDoc = catalogInfo.first;
      final data = lastCatalogDoc.data();
      final images = data['downloadUrls'] as List<dynamic>?;

      return images?.map((e) => e.toString()).toList() ?? [];
    } catch (e) {
      throw Exception('Error al obtener imágenes del catálogo: $e');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email,
      actionCodeSettings: ActionCodeSettings(
        url: 'https://smartcatalog-32439.web.app/reset-password',
        handleCodeInApp: true,
        iOSBundleId: 'com.pcreat.smartCatalog',
        androidPackageName: 'com.pcreat.smart_catalog',
        androidInstallApp: true,
      ),
    );
  }
}
