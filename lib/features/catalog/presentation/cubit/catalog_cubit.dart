import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';
import 'package:smart_catalog/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
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
        .then((page) {
          final productsCode = page.productsCode;
          if (productsCode.isEmpty) {
            debugPrint('catalog cubit Error: no products found');
            emit(CatalogError(message: 'errors.catalog_error'.tr()));
          } else {
            final cartProducts = CartSession.instance.cartProducts;
            final products = productsCode.map((code) {
              return cartProducts.firstWhere(
                (p) => p.id == code,
                orElse: () => CartProductViewModel(id: code, quantity: '0'),
              );
            }).toList();
            emit(ProductsLoaded(products: products));
          }
        })
        .catchError((error) {
          debugPrint(
            'catalog cubit getProductsCodeByPage Error: ${error.toString()}',
          );
          emit(CatalogError(message: 'errors.get_products_code_error'.tr()));
        });
  }

  void addProductsCodeToCart(List<CartProductViewModel> products) async {
    try {
      emit(CatalogLoading());
      final Map<String, CartProductEntity> productsEntityMap = {
        for (var product in products)
          product.id: CartProductEntity(
            id: product.id,
            quantity: int.parse(product.quantity),
          ),
      };
      CartSession.instance.addProductList(products);
      await _addProductsToCartLocals();
      emit(ProductsAddedToCart());
      await _catalogRepository.addProductsCodeToCart(productsEntityMap);
    } catch (e) {
      debugPrint('catalog cubit addProductsCodeToCart Error: ${e.toString()}');
      emit(CatalogError(message: 'errors.add_products_error'.tr()));
    }
  }

  Future<void> _addProductsToCartLocals() async {
    final products = CartSession.instance.cartProducts;
    final productsEntityMap = products
        .map(
          (e) => CartProductEntity(id: e.id, quantity: int.parse(e.quantity)),
        )
        .toList();
    await _catalogRepository.addProductsLocal(productsEntityMap);
  }

  void navigateToCart() {
    emit(CatalogNavigatingToCart());
  }
}
