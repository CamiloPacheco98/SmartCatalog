import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';

class CartProductViewModel {
  final String id;
  final String quantity;

  CartProductViewModel({required this.id, required this.quantity});

  factory CartProductViewModel.fromEntity(CartProductEntity entity) {
    final quantity = entity.quantity.toString();
    return CartProductViewModel(id: entity.id, quantity: quantity);
  }

  CartProductViewModel copyWith({String? quantity}) {
    return CartProductViewModel(id: id, quantity: quantity ?? this.quantity);
  }
}
