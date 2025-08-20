import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartProductViewModel> _products = [];
  final CartRepository _cartRepository;
  CartCubit({required CartRepository cartRepository})
    : _cartRepository = cartRepository,
      super(CartInitial()) {
    getCartProducts();
  }

  Future<void> getCartProducts() async {
    emit(CartLoading());
    try {
      final products = await _cartRepository.getCartProducts();
      if (products == null) {
        emit(CartLoaded([]));
        return;
      }
      _products = products.entries
          .map((entry) => CartProductViewModel.fromEntity(entry.value))
          .toList();
      emit(CartLoaded(_products));
    } catch (e) {
      debugPrint('Error getting cart products: $e');
      emit(CartLoaded([]));
    }
  }

  Future<void> increaseQuantity(String productId) async {
    _products = _products.map((product) {
      if (product.id == productId) {
        final quantity = int.parse(product.quantity) + 1;
        return product.copyWith(quantity: quantity.toString());
      }
      return product;
    }).toList();
    emit(CartLoaded(_products));
  }

  Future<void> decreaseQuantity(String productId) async {
    _products = _products.map((product) {
      if (product.id == productId) {
        final quantity = int.parse(product.quantity) - 1;
        return product.copyWith(quantity: quantity.toString());
      }
      return product;
    }).toList();
    emit(CartLoaded(_products));
  }
}
