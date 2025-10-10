import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:smart_catalog/core/domain/entities/product_entity.dart';
import 'package:smart_catalog/features/catalog/domain/entities/catalog_page_entity.dart';
import 'package:smart_catalog/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:smart_catalog/core/data/models/product_model.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  final Box<Map> _cartBox;

  CatalogRepositoryImpl({
    required FirebaseFirestore db,
    required FirebaseAuth auth,
    required Box<Map> cartBox,
  }) : _db = db,
       _auth = auth,
       _cartBox = cartBox;

  @override
  Future<CatalogPageEntity> getProductsByPage(int page) async {
    return await _db
        .collection(FirestoreCollections.catalog)
        .where('pageIndex', isEqualTo: page)
        .get()
        .then((querySnapshot) {
          final products = querySnapshot.docs
              .map((doc) => ProductModel.fromJson(doc.data()).toEntity())
              .toList();
          return CatalogPageEntity(page: page, products: products);
        });
  }

  @override
  Future<void> addProductsCodeToCart(
    Map<String, ProductEntity> products,
  ) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    final productsJson = products.map(
      (key, value) => MapEntry(key, ProductModel.fromEntity(value).toJson()),
    );
    await _db
        .collection(FirestoreCollections.cart)
        .doc(uid)
        .set(productsJson, SetOptions(merge: true));
  }

  @override
  Future<void> addProductsLocal(List<ProductEntity> products) async {
    // TODO: Improve cart box with putAll
    await _cartBox.clear();
    await _cartBox.addAll(
      products.map((e) => ProductModel.fromEntity(e).toJson()),
    );
  }
}
