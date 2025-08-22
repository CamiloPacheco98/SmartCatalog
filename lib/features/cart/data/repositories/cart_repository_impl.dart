import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:smart_catalog/core/data/models/cart_product_model.dart';
import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';

class CartRepositoryImpl extends CartRepository {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  CartRepositoryImpl({
    required FirebaseFirestore db,
    required FirebaseAuth auth,
  }) : _db = db,
       _auth = auth;

  @override
  Future<Map<String, CartProductEntity>?> getCartProducts() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    final products = await _db
        .collection(FirestoreCollections.cart)
        .doc(uid)
        .get()
        .then((value) => value.data());
    if (products == null) return {};
    return products.map(
      (key, value) => MapEntry(key, CartProductModel.fromJson(value)),
    );
  }
}
