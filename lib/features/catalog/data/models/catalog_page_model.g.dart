// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogPageModel _$CatalogPageModelFromJson(Map<String, dynamic> json) =>
    CatalogPageModel(
      page: (json['page'] as num).toInt(),
      productsCode: (json['productsCode'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CatalogPageModelToJson(CatalogPageModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'productsCode': instance.productsCode,
    };
