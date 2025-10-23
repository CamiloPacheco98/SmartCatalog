part of 'cart_cubit.dart';

@immutable
sealed class CartState {
  final List<CartProductViewModel> products;

  const CartState({required this.products});
}

final class CartInitial extends CartState {
  const CartInitial({required super.products});
}

final class CartLoading extends CartState {
  const CartLoading({required super.products});
}

final class CartLoaded extends CartState {
  const CartLoaded({required super.products});
}

final class CartSuccess extends CartState {
  final String message;

  const CartSuccess({required super.products, required this.message});
}

final class CartError extends CartState {
  final String message;

  const CartError({required super.products, required this.message});
}
