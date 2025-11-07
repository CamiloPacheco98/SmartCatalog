import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/domain/entities/product_entity.dart';
import 'package:smart_catalog/core/session/catalog_session.dart';
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
    final products = _getProductsByPage(page);
    if (products.isEmpty) {
      debugPrint('catalog cubit Error: no products found');
      emit(CatalogError(message: 'errors.get_products_code_error'.tr()));
    } else {
      final cartProducts = CartSession.instance.cartProducts;
      final productsViewModel = products.map((product) {
        return cartProducts.firstWhere(
          (p) => p.id == product.id,
          orElse: () => product,
        );
      }).toList();
      emit(ProductsLoaded(products: productsViewModel));
    }
  }

  List<CartProductViewModel> _getProductsByPage(int page) {
    final catalog = CatalogSession.instance.catalog;
    return catalog?.products ?? [];
  }

  void addProductsCodeToCart(List<CartProductViewModel> products) async {
    try {
      emit(CatalogLoading());
      final Map<String, ProductEntity> productsEntityMap = {
        for (var product in products)
          product.id: ProductEntity(
            id: product.id,
            name: product.name,
            desc: product.desc,
            price: product.price,
            createdAt: product.createdAt,
            updatedAt: product.updatedAt,
            quantity: product.quantity,
            pageName: product.pageName,
            pageIndex: product.pageIndex,
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
          (e) => ProductEntity(
            id: e.id,
            name: e.name,
            desc: e.desc,
            price: e.price,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
            quantity: e.quantity,
            pageName: e.pageName,
            pageIndex: e.pageIndex,
          ),
        )
        .toList();
    await _catalogRepository.addProductsLocal(productsEntityMap);
  }

  void navigateToCart() {
    emit(CatalogNavigatingToCart());
  }
}
