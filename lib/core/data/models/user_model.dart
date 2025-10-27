import 'package:json_annotation/json_annotation.dart';
import 'package:smart_catalog/core/domain/entities/user_entity.dart';
import 'package:smart_catalog/core/utils/timestap_converter.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final bool verified;
  final String name;
  final String lastName;
  final String documentNumber;
  final String imagePath;
  final String email;
  final String adminUid;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.verified,
    required this.name,
    required this.lastName,
    required this.documentNumber,
    required this.imagePath,
    required this.email,
    required this.adminUid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
    id: entity.id,
    verified: entity.verified,
    name: entity.name,
    lastName: entity.lastName,
    documentNumber: entity.documentNumber,
    imagePath: entity.imagePath,
    email: entity.email,
    adminUid: entity.adminUid,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );

  UserEntity toEntity() => UserEntity(
    id: id,
    verified: verified,
    name: name,
    lastName: lastName,
    documentNumber: documentNumber,
    imagePath: imagePath,
    email: email,
    adminUid: adminUid,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
