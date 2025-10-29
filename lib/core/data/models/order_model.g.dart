// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String,
  adminUid: json['adminUid'] as String,
  products: OrderModel._productsFromJson(json['products'] as List),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  total: (json['total'] as num).toInt(),
  user: OrderModel._userFromJson(json['user']),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adminUid': instance.adminUid,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'status': _$OrderStatusEnumMap[instance.status]!,
      'total': instance.total,
      'user': instance.user.toJson(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
