import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';

enum OrderStatus { pending, completed, cancelled }

class OrderEntity {
  final String id;
  final List<CartProductEntity> products;
  final DateTime createdAt;
  final OrderStatus status;
  final int total;

  OrderEntity({
    required this.id,
    required this.products,
    required this.createdAt,
    required this.status,
    required this.total,
  });
}
