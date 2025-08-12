import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_catalog/features/catalog/domain/catalog_repository.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<String>> getProductsCodeByPage(int page) async {
    return await _db
        .collection(FirestoreCollections.catalog)
        .doc(page.toString())
        .get()
        .then((event) {
          final data = event.data();
          if (data == null) {
            return [];
          }
          //TODO: use a object here
          final productsCode = data['productsCode'] as List<dynamic>;
          return productsCode.map((e) => e.toString()).toList();
        });
  }
}
