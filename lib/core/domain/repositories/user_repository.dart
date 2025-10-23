import 'package:smart_catalog/core/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String userId);
  Future<UserEntity> getLocalUser();
  Future<void> saveLocalUser(UserEntity user);
}
