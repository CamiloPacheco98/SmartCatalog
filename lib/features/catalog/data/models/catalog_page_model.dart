import 'package:json_annotation/json_annotation.dart';
import 'package:smart_catalog/features/catalog/domain/entities/catalog_page_entity.dart';
part 'catalog_page_model.g.dart';

@JsonSerializable()
class CatalogPageModel {
  final int page;
  final List<String> productsCode;
  CatalogPageModel({required this.page, required this.productsCode});

  factory CatalogPageModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogPageModelToJson(this);

  CatalogPageEntity toEntity() =>
      CatalogPageEntity(page: page, productsCode: productsCode);
}
