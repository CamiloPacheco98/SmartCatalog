import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/features/catalog/domain/catalog_repository.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final CatalogRepository _catalogRepository;

  CatalogCubit({required CatalogRepository catalogRepository})
    : _catalogRepository = catalogRepository,
      super(CatalogInitial());

  void getProductsCodeByPage(int page) async {
    emit(ProductsCodeLoading());
    _catalogRepository
        .getProductsCodeByPage(page)
        .then((productsCode) {
          if (productsCode.isEmpty) {
            debugPrint('catalog cubit Error: no products found');
            emit(ProductsCodeError(message: 'errors.catalog_error'.tr()));
          } else {
            emit(ProductsCodeLoaded(productsCode: productsCode));
          }
        })
        .catchError((error) {
          debugPrint('catalog cubit Error: ${error.toString()}');
          emit(ProductsCodeError(message: 'errors.catalog_error'.tr()));
        });
  }
}
