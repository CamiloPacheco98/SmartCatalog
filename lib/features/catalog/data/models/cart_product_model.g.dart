// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProductModel _$CartProductModelFromJson(Map<String, dynamic> json) =>
    CartProductModel(
      id: json['id'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartProductModelToJson(CartProductModel instance) =>
    <String, dynamic>{'id': instance.id, 'quantity': instance.quantity};
