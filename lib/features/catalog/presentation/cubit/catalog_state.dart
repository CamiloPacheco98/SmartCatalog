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

final class ProductsLoaded extends CatalogState {
  final List<CartProductViewModel> products;

  const ProductsLoaded({required this.products});
}

final class ProductsAddedToCart extends CatalogState {
  const ProductsAddedToCart();
}

final class CatalogNavigatingToCart extends CatalogState {
  const CatalogNavigatingToCart();
}
