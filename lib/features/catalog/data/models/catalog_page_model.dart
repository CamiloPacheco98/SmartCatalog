import 'package:json_annotation/json_annotation.dart';
import 'package:smart_catalog/features/catalog/domain/entities/catalog_page_entity.dart';
import 'package:smart_catalog/core/data/models/product_model.dart';
part 'catalog_page_model.g.dart';

@JsonSerializable()
class CatalogPageModel {
  final int page;
  final List<ProductModel> products;
  CatalogPageModel({required this.page, required this.products});

  factory CatalogPageModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogPageModelToJson(this);

  CatalogPageEntity toEntity() => CatalogPageEntity(
    page: page,
    products: products.map((e) => e.toEntity()).toList(),
  );
}
