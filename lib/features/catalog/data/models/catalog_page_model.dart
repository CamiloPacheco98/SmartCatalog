import 'package:smart_catalog/features/catalog/domain/entities/catalog_page.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catalog_page_model.g.dart';

@JsonSerializable()
class CatalogPageModel extends CatalogPage {
  CatalogPageModel({required super.page, required super.productsCode});

  factory CatalogPageModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogPageModelToJson(this);
}
