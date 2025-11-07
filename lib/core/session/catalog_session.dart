import 'package:smart_catalog/core/domain/entities/catalog_entity.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:smart_catalog/features/cart/presentation/models/catalog_view_model.dart';

class CatalogSession {
  static CatalogSession? _instance;
  CatalogViewModel? _catalog;

  CatalogSession._();

  static CatalogSession get instance {
    _instance ??= CatalogSession._();
    return _instance!;
  }

  CatalogViewModel? get catalog => _catalog;

  void setCatalog(CatalogEntity? catalogEntity) {
    if (catalogEntity == null) {
      return;
    }
    final products = catalogEntity.products;
    final productsViewModel = products
        .map(
          (product) => CartProductViewModel(
            id: product.id,
            name: product.name,
            price: product.price,
            pageIndex: product.pageIndex,
            quantity: product.quantity,
            desc: product.desc,
            createdAt: product.createdAt,
            updatedAt: product.updatedAt,
            pageName: '',
          ),
        )
        .toList();
    _catalog = CatalogViewModel(
      downloadUrls: catalogEntity.downloadUrls,
      totalPages: catalogEntity.totalPages,
      products: productsViewModel,
    );
  }
}
