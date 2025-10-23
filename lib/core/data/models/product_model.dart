import 'package:json_annotation/json_annotation.dart';
import 'package:smart_catalog/core/utils/timestap_converter.dart';
import 'package:smart_catalog/core/domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  @JsonKey(defaultValue: '')
  final String desc;
  final int price;
  final int pageIndex;
  final String pageName;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
  @JsonKey(defaultValue: '0')
  final String quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.pageIndex,
    required this.pageName,
    required this.createdAt,
    required this.updatedAt,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      desc: entity.desc,
      price: entity.price,
      pageIndex: entity.pageIndex,
      pageName: entity.pageName,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      quantity: entity.quantity,
    );
  }

  ProductEntity toEntity() => ProductEntity(
    id: id,
    name: name,
    desc: desc,
    price: price,
    pageIndex: pageIndex,
    pageName: pageName,
    createdAt: createdAt,
    updatedAt: updatedAt,
    quantity: quantity,
  );

  ProductModel copyWith({
    String? id,
    String? name,
    String? desc,
    int? price,
    int? pageIndex,
    String? pageName,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      pageIndex: pageIndex ?? this.pageIndex,
      pageName: pageName ?? this.pageName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      quantity: quantity ?? this.quantity,
    );
  }
}
