import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
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
  }

  Future<void> decreaseQuantity(String productId) async {
    final index = _products.indexWhere((product) => product.id == productId);
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
  }

  Future<void> deleteProduct(CartProductViewModel product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    _products.remove(product);
    CartSession.instance.removeProduct(product);
    await _cartRepository.deleteProductLocalAt(index);
    emit(CartLoaded(_products));
    await _cartRepository.deleteProduct(product.id);
  }
}
