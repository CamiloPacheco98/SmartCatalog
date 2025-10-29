import 'package:smart_catalog/core/domain/entities/product_entity.dart';
import 'package:smart_catalog/core/domain/entities/user_entity.dart';

enum OrderStatus { pending, completed, cancelled }

class OrderEntity {
  final String id;
  final String adminUid;
  final List<ProductEntity> products;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrderStatus status;
  final int total;
  final UserEntity user;

  OrderEntity({
    required this.id,
    required this.adminUid,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.total,
    required this.user,
  });
}
