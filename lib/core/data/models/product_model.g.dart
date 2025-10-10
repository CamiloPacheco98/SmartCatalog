// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String,
  name: json['name'] as String,
  desc: json['desc'] as String? ?? '',
  price: (json['price'] as num).toInt(),
  pageIndex: (json['pageIndex'] as num).toInt(),
  pageName: json['pageName'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  quantity: json['quantity'] as String? ?? '0',
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'price': instance.price,
      'pageIndex': instance.pageIndex,
      'pageName': instance.pageName,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'quantity': instance.quantity,
    };
