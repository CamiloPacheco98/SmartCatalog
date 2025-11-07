// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogModel _$CatalogModelFromJson(Map<String, dynamic> json) => CatalogModel(
  downloadUrls: (json['downloadUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalProducts: (json['totalProducts'] as num).toInt(),
  products: (json['products'] as List<dynamic>)
      .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$CatalogModelToJson(CatalogModel instance) =>
    <String, dynamic>{
      'downloadUrls': instance.downloadUrls,
      'totalPages': instance.totalPages,
      'totalProducts': instance.totalProducts,
      'products': instance.products,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
