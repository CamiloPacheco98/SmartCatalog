import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_product_model.g.dart';

@JsonSerializable()
class CartProductModel extends CartProductEntity {
  CartProductModel({required super.id, required super.quantity});

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      _$CartProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductModelToJson(this);

  factory CartProductModel.fromEntity(CartProductEntity entity) {
    return CartProductModel(id: entity.id, quantity: entity.quantity);
  }

  CartProductModel copyWith({int? quantity}) {
    return CartProductModel(id: id, quantity: quantity ?? this.quantity);
  }
}
