import 'package:smart_catalog/features/catalog/domain/entities/cart_products_entity.dart';

class CartProductViewModel {
  final String id;
  final String quantity;

  CartProductViewModel({required this.id, required this.quantity});

  factory CartProductViewModel.fromEntity({
    required CartProductEntity entity,
    required String id,
  }) {
    final quantity = entity.quantity.toString();
    return CartProductViewModel(id: id, quantity: quantity);
  }

  CartProductViewModel copyWith({String? quantity}) {
    return CartProductViewModel(id: id, quantity: quantity ?? this.quantity);
  }
}
