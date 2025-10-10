import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_catalog/core/domain/entities/product_entity.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/session/orders_session.dart';
import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartProductViewModel> _products = [];
  final CartRepository _cartRepository;
  CartCubit({
    required CartRepository cartRepository,
    required List<CartProductViewModel> products,
  }) : _cartRepository = cartRepository,
       super(CartInitial()) {
    _products = products;
    emit(CartLoaded(_products));
  }

  Future<void> increaseQuantity(String productId) async {
    try {
      final index = _products.indexWhere((product) => product.id == productId);
      await _cartRepository.increaseQuantityLocalAt(index);
      _products = _products.map((product) {
        if (product.id == productId) {
          return product.copyWith(
            quantity: (int.parse(product.quantity) + 1).toString(),
          );
        }
        return product;
      }).toList();
      CartSession.instance.addProductList(_products);
      emit(CartLoaded(_products));
      await _cartRepository.increaseQuantity(productId);
    } catch (e) {
      debugPrint('error increasing quantity: ${e.toString()}');
      emit(CartError('errors.increase_quantity_error'.tr()));
    }
  }

  Future<void> decreaseQuantity(String productId) async {
    final index = _products.indexWhere((product) => product.id == productId);
    try {
      await _cartRepository.decreaseQuantityLocalAt(index);
      _products = _products.map((product) {
        if (product.id == productId) {
          return product.copyWith(
            quantity: (int.parse(product.quantity) - 1).toString(),
          );
        }
        return product;
      }).toList();
      CartSession.instance.addProductList(_products);
      emit(CartLoaded(_products));
      await _cartRepository.decreaseQuantity(productId);
    } catch (e) {
      debugPrint('error decreasing quantity: ${e.toString()}');
      emit(CartError('errors.decrease_quantity_error'.tr()));
    }
  }

  Future<void> deleteProduct(CartProductViewModel product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    try {
      _products.remove(product);
      CartSession.instance.removeProduct(product);
      await _cartRepository.deleteProductLocalAt(index);
      emit(CartLoaded(_products));
      await _cartRepository.deleteProduct(product.id);
    } catch (e) {
      debugPrint('error deleting product: ${e.toString()}');
      emit(CartError('errors.delete_product_error'.tr()));
    }
  }

  Future<void> makeOrder() async {
    emit(CartLoading());
    final products = _products
        .map(
          (e) => ProductEntity(id: e.id,
            name: e.name,
            desc: e.desc,
            price: e.price,
            pageIndex: e.pageIndex,
            pageName: e.pageName,
            createdAt: e.createdAt, updatedAt: e.updatedAt, quantity: e.quantity),
        )
        .toList();

    final order = OrderEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      products: products,
      createdAt: DateTime.now(),
      status: OrderStatus.pending,
      total: _products.fold<int>(
        0,
        (sum, product) => sum + int.parse(product.quantity),
      ),
    );
    try {
      await _cartRepository.makeOrder(order);
      await _cartRepository.saveOrderLocal(order);
      OrdersSession.instance.addOrder(order);
      await _makeOrderSuccess();
    } catch (e) {
      debugPrint('error making order: ${e.toString()}');
      emit(CartError('errors.make_order_error'.tr()));
    }
  }

  Future<void> _makeOrderSuccess() async {
    _products = [];
    CartSession.instance.clearCart();
    await _cartRepository.deleteAllProducts();
    await _cartRepository.deleteAllProductsLocal();
    emit(CartSuccess('success.order_made_successfully'.tr()));
    emit(CartLoaded(_products));
  }
}
