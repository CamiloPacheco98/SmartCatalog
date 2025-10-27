class UserEntity {
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
  UserEntity({
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
}
