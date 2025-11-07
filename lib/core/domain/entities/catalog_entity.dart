import 'package:smart_catalog/core/domain/entities/product_entity.dart';

class CatalogEntity {
  final List<String> downloadUrls;
  final int totalPages;
  final int totalProducts;
  final List<ProductEntity> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CatalogEntity({
    required this.downloadUrls,
    required this.totalPages,
    required this.totalProducts,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });
}
