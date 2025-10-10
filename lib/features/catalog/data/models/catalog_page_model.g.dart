// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogPageModel _$CatalogPageModelFromJson(Map<String, dynamic> json) =>
    CatalogPageModel(
      page: (json['page'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CatalogPageModelToJson(CatalogPageModel instance) =>
    <String, dynamic>{'page': instance.page, 'products': instance.products};
