// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  verified: json['verified'] as bool,
  name: json['name'] as String,
  lastName: json['lastName'] as String,
  documentNumber: json['documentNumber'] as String,
  imagePath: json['imagePath'] as String,
  email: json['email'] as String,
  adminUid: json['adminUid'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'verified': instance.verified,
  'name': instance.name,
  'lastName': instance.lastName,
  'documentNumber': instance.documentNumber,
  'imagePath': instance.imagePath,
  'email': instance.email,
  'adminUid': instance.adminUid,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
