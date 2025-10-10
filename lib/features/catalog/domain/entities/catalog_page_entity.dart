import 'package:smart_catalog/core/domain/entities/product_entity.dart';

class CatalogPageEntity {
  final int page;
  final List<ProductEntity> products;

  const CatalogPageEntity({required this.page, required this.products});
}
