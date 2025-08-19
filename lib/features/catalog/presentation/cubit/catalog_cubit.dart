import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/features/catalog/domain/entities/cart_products_entity.dart';
import 'package:smart_catalog/features/catalog/domain/repositories/catalog_repository.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final CatalogRepository _catalogRepository;

  CatalogCubit({required CatalogRepository catalogRepository})
    : _catalogRepository = catalogRepository,
      super(CatalogInitial());

  void getProductsCodeByPage(int page) async {
    emit(CatalogLoading());
    _catalogRepository
        .getProductsCodeByPage(page)
        .then((catalogPage) {
          final productsCode = catalogPage.productsCode;
          if (productsCode.isEmpty) {
            debugPrint('catalog cubit Error: no products found');
            emit(CatalogError(message: 'errors.catalog_error'.tr()));
          } else {
            emit(ProductsCodeLoaded(productsCode: productsCode));
          }
        })
        .catchError((error) {
          debugPrint(
            'catalog cubit getProductsCodeByPage Error: ${error.toString()}',
          );
          emit(CatalogError(message: 'errors.get_products_code_error'.tr()));
        });
  }

  void addProductsCodeToCart(List<String> productsCode) async {
    try {
      emit(CatalogLoading());
      final products = Map.fromEntries(
        productsCode.map(
          (code) => MapEntry(code, CartProductEntity(quantity: 1)),
        ),
      );
      await _catalogRepository.addProductsCodeToCart(products);
      emit(ProductsCodeAddedToCart());
    } catch (e) {
      debugPrint('catalog cubit addProductsCodeToCart Error: ${e.toString()}');
      emit(CatalogError(message: 'errors.add_products_error'.tr()));
    }
  }

  void navigateToCart() {
    emit(CatalogNavigatingToCart());
  }
}
