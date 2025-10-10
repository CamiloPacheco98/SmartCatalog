import 'package:smart_catalog/core/domain/entities/product_entity.dart';
import 'package:smart_catalog/features/catalog/domain/entities/catalog_page_entity.dart';

abstract class CatalogRepository {
  Future<CatalogPageEntity> getProductsByPage(int page);
  Future<void> addProductsCodeToCart(Map<String, ProductEntity> products);
  Future<void> addProductsLocal(List<ProductEntity> products);
}
