import 'package:smart_catalog/features/catalog/domain/entities/catalog_page.dart';

abstract class CatalogRepository {
  Future<CatalogPage> getProductsCodeByPage(int page);
}
