import 'package:smart_catalog/features/catalog/domain/entities/catalog_page_entity.dart';

abstract class CatalogRepository {
  Future<CatalogPageEntity> getProductsCodeByPage(int page);
}
