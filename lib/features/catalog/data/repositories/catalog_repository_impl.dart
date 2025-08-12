import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_catalog/features/catalog/domain/entities/catalog_page_entity.dart';
import 'package:smart_catalog/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:smart_catalog/features/catalog/data/models/catalog_page_model.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
}
