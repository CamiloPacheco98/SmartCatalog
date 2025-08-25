part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartProductViewModel> products;

  CartLoaded(this.products);
}

final class CartSuccess extends CartState {
  final String message;

  CartSuccess(this.message);
}
