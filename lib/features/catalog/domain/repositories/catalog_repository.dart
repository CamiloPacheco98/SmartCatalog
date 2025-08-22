import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';
import 'package:smart_catalog/features/catalog/domain/entities/catalog_page_entity.dart';

abstract class CatalogRepository {
  Future<CatalogPageEntity> getProductsCodeByPage(int page);
  Future<void> addProductsCodeToCart(Map<String, CartProductEntity> products);
  Future<void> addProductsLocal(List<CartProductEntity> products);
}
