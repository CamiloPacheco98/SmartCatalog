// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String,
  products: OrderModel._productsFromJson(json['products'] as List),
  createdAt: DateTime.parse(json['createdAt'] as String),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$OrderStatusEnumMap[instance.status]!,
      'total': instance.total,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
