import 'package:smart_catalog/core/domain/entities/product_entity.dart';

enum OrderStatus { pending, completed, cancelled }

class OrderEntity {
  final String id;
  final List<ProductEntity> products;
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
