import 'package:smart_catalog/core/domain/entities/user_entity.dart';
import 'package:smart_catalog/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser(String userId);
  Future<Either<Failure, UserEntity>> getLocalUser();
  Future<void> saveLocalUser(UserEntity user);
}
