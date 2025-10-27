import 'package:smart_catalog/core/domain/entities/user_entity.dart';

class UserViewModel {
  final String id;
  final String name;
  final String lastName;
  final String documentNumber;
  final String imagePath;
  final String email;
  final String adminUid;
  final bool verified;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserViewModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.documentNumber,
    required this.imagePath,
    required this.email,
    required this.adminUid,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
  });
  factory UserViewModel.fromEntity(UserEntity entity) => UserViewModel(
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
}
