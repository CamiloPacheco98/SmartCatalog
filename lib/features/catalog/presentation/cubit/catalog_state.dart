part of 'catalog_cubit.dart';

@immutable
sealed class CatalogState {
  const CatalogState();
}

final class CatalogInitial extends CatalogState {
  const CatalogInitial();
}

final class CatalogError extends CatalogState {
  final String message;

  const CatalogError({required this.message});
}

final class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

final class ProductsCodeLoaded extends CatalogState {
  final List<String> productsCode;

  const ProductsCodeLoaded({required this.productsCode});
}

final class ProductsCodeAddedToCart extends CatalogState {
  const ProductsCodeAddedToCart();
}
