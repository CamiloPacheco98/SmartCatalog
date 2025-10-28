import 'package:smart_catalog/core/domain/entities/user_entity.dart';
import 'package:smart_catalog/core/domain/repositories/user_repository.dart';
import 'package:smart_catalog/core/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:hive/hive.dart';
import 'package:smart_catalog/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final Box<Map> _userBox;
  UserRepositoryImpl({
    required FirebaseFirestore firestore,
    required Box<Map> userBox,
  }) : _firestore = firestore,
       _userBox = userBox;

  @override
  Future<Either<Failure, UserEntity>> getLocalUser() async {
    try {
      final user = UserModel.fromJson(
        Map<String, dynamic>.from(_userBox.values.first),
      ).toEntity();
      return Right(user);
    } catch (e) {
      return Left(UserNotFoundFailure());
    }
  }

  @override
  Future<void> saveLocalUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await _userBox.put(user.id, userModel.toJson());
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String userId) async {
    try {
      final user = await _firestore
          .collection(FirestoreCollections.users)
          .doc(userId)
          .get();
      if (user.exists) {
        final userData = user.data() ?? {};
        return Right(UserModel.fromJson(userData).toEntity());
      }
      return Left(UserNotFoundFailure());
    } catch (e) {
      return Left(UserNotFoundFailure());
    }
  }
}
