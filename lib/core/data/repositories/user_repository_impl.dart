import 'package:smart_catalog/core/domain/entities/user_entity.dart';
import 'package:smart_catalog/core/domain/repositories/user_repository.dart';
import 'package:smart_catalog/core/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:hive/hive.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final Box<Map> _userBox;
  UserRepositoryImpl({
    required FirebaseFirestore firestore,
    required Box<Map> userBox,
  }) : _firestore = firestore,
       _userBox = userBox;

  @override
  Future<UserEntity> getLocalUser() async {
    return UserModel.fromJson(
      Map<String, dynamic>.from(_userBox.values.first),
    ).toEntity();
  }

  @override
  Future<void> saveLocalUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await _userBox.put(user.id, userModel.toJson());
  }

  @override
  Future<UserEntity> getUser(String userId) async {
    final user = await _firestore
        .collection(FirestoreCollections.users)
        .doc(userId)
        .get();
    if (user.exists) {
      return UserModel.fromJson(user.data() ?? {}).toEntity();
    }
    return UserEntity(
      id: userId,
      name: '',
      lastName: '',
      document: '',
      imagePath: '',
      email: '',
      adminUid: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
