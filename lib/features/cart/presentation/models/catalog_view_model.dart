import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';

class CatalogViewModel {
  final List<String> downloadUrls;
  final int totalPages;
  final List<CartProductViewModel> products;

  CatalogViewModel({
    required this.downloadUrls,
    required this.totalPages,
    required this.products,
  });
}
