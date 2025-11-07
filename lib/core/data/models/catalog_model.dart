import 'package:json_annotation/json_annotation.dart';
import 'package:smart_catalog/core/data/models/product_model.dart';
import 'package:smart_catalog/core/domain/entities/catalog_entity.dart';
import 'package:smart_catalog/core/utils/timestap_converter.dart';

part 'catalog_model.g.dart';

@JsonSerializable()
class CatalogModel {
  final List<String> downloadUrls;
  final int totalPages;
  final int totalProducts;
  final List<ProductModel> products;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;

  CatalogModel({
    required this.downloadUrls,
    required this.totalPages,
    required this.totalProducts,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogModelFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogModelToJson(this);

  factory CatalogModel.fromEntity(CatalogEntity entity) => CatalogModel(
    downloadUrls: entity.downloadUrls,
    totalPages: entity.totalPages,
    totalProducts: entity.totalProducts,
    products: entity.products.map((e) => ProductModel.fromEntity(e)).toList(),
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );

  CatalogEntity toEntity() => CatalogEntity(
    downloadUrls: downloadUrls,
    totalPages: totalPages,
    totalProducts: totalProducts,
    products: products.map((e) => e.toEntity()).toList(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
