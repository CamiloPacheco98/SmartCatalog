import 'package:json_annotation/json_annotation.dart';
import 'package:smart_catalog/core/data/models/product_model.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/core/data/models/user_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final String id;
  final String adminUid;
  @JsonKey(fromJson: _productsFromJson)
  final List<ProductModel> products;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrderStatus status;
  final int total;
  @JsonKey(fromJson: _userFromJson)
  final UserModel user;

  OrderModel({
    required this.id,
    required this.adminUid,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.total,
    required this.user,
  });

  factory OrderModel.fromEntity(OrderEntity entity) => OrderModel(
    id: entity.id,
    adminUid: entity.adminUid,
    products: entity.products.map((e) => ProductModel.fromEntity(e)).toList(),
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    status: entity.status,
    total: entity.total,
    user: UserModel.fromEntity(entity.user),
  );

  OrderEntity toEntity() => OrderEntity(
    id: id,
    adminUid: adminUid,
    products: products.map((e) => e.toEntity()).toList(),
    createdAt: createdAt,
    updatedAt: updatedAt,
    status: status,
    total: total,
    user: user.toEntity(),
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  //Added to fix hive returning a Map<dynamic, dynamic> instead Map<String, dynamic>
  static List<ProductModel> _productsFromJson(List<dynamic> jsonList) =>
      jsonList
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

  static UserModel _userFromJson(dynamic json) =>
      UserModel.fromJson(Map<String, dynamic>.from(json));
}
