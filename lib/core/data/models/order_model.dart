import 'package:json_annotation/json_annotation.dart';
import 'package:smart_catalog/core/data/models/cart_product_model.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String id;
  final List<CartProductModel> products;
  final DateTime createdAt;
  final OrderStatus status;
  final int total;

  OrderModel({
    required this.id,
    required this.products,
    required this.createdAt,
    required this.status,
    required this.total,
  });

  factory OrderModel.fromEntity(OrderEntity entity) => OrderModel(
    id: entity.id,
    products: entity.products
        .map((e) => CartProductModel.fromEntity(e))
        .toList(),
    createdAt: entity.createdAt,
    status: entity.status,
    total: entity.total,
  );

  OrderEntity toEntity() => OrderEntity(
    id: id,
    products: products.map((e) => e.toEntity()).toList(),
    createdAt: createdAt,
    status: status,
    total: total,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
