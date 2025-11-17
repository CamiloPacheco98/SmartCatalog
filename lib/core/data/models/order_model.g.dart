// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String,
  adminUid: json['adminUid'] as String,
  products: OrderModel._productsFromJson(json['products'] as List),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  total: (json['total'] as num).toInt(),
  user: OrderModel._userFromJson(json['user']),
  discountPercentage: (json['discountPercentage'] as num).toInt(),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adminUid': instance.adminUid,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'status': _$OrderStatusEnumMap[instance.status]!,
      'total': instance.total,
      'user': instance.user.toJson(),
      'discountPercentage': instance.discountPercentage,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
