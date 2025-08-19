import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
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
      final cartProducts = products.entries
          .map(
            (entry) => CartProductViewModel.fromEntity(
              entity: entry.value,
              id: entry.key,
            ),
          )
          .toList();
      emit(CartLoaded(cartProducts));
    } catch (e) {
      debugPrint('Error getting cart products: $e');
      emit(CartLoaded([]));
    }
  }
}
