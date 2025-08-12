part of 'catalog_cubit.dart';

@immutable
sealed class CatalogState {
  const CatalogState();
}

final class CatalogInitial extends CatalogState {
  const CatalogInitial();
}

final class ProductsCodeLoaded extends CatalogState {
  final List<String> productsCode;

  const ProductsCodeLoaded({required this.productsCode});
}

final class ProductsCodeError extends CatalogState {
  final String message;

  const ProductsCodeError({required this.message});
}

final class ProductsCodeLoading extends CatalogState {
  const ProductsCodeLoading();
}
