import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_catalog/features/catalog/domain/entities/cart_products_entity.dart';
import 'package:smart_catalog/features/catalog/domain/entities/catalog_page_entity.dart';
import 'package:smart_catalog/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:smart_catalog/features/catalog/data/models/cart_product_model.dart';
import 'package:smart_catalog/features/catalog/data/models/catalog_page_model.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  CatalogRepositoryImpl({
    required FirebaseFirestore db,
    required FirebaseAuth auth,
  }) : _db = db,
       _auth = auth;

  @override
  Future<CatalogPageEntity> getProductsCodeByPage(int page) async {
    return await _db
        .collection(FirestoreCollections.catalog)
        .doc(page.toString())
        .get()
        .then((event) {
          final data = event.data();
          if (data == null) {
            throw Exception('Catalog page not found');
          }
          return CatalogPageModel.fromJson(data);
        });
  }

  @override
  Future<void> addProductsCodeToCart(
    Map<String, CartProductEntity> products,
  ) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    final productsJson = products.map(
      (key, value) =>
          MapEntry(key, CartProductModel.fromEntity(value).toJson()),
    );
    await _db
        .collection(FirestoreCollections.cart)
        .doc(uid)
        .set(productsJson, SetOptions(merge: true));
  }
}
