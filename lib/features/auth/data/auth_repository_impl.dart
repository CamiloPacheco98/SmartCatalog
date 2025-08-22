import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:smart_catalog/features/catalog/data/models/cart_product_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Box<CartProductEntity> _cartBox;
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  AuthRepositoryImpl({
    required Box<CartProductEntity> cartBox,
    required FirebaseAuth auth,
    required FirebaseFirestore db,
  }) : _cartBox = cartBox,
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

  @override
  Future<void> saveLocalCartProducts(List<CartProductEntity> products) async {
    await _cartBox.addAll(products);
  }
}
