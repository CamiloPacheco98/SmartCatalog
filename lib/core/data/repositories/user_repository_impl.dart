import 'package:smart_catalog/core/domain/entities/user_entity.dart';
import 'package:smart_catalog/core/domain/repositories/user_repository.dart';
import 'package:smart_catalog/core/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';
import 'package:hive/hive.dart';
import 'package:smart_catalog/core/data/source/firebase_storage_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorageDatasource _firebaseStorageDatasource;
  final Box<Map> _userBox;
  UserRepositoryImpl({
    required FirebaseFirestore firestore,
    required FirebaseStorageDatasource firebaseStorageDatasource,
    required Box<Map> userBox,
  }) : _firestore = firestore,
       _firebaseStorageDatasource = firebaseStorageDatasource,
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
      final userData = user.data() ?? {};
      final imagePath = userData.containsKey('imagePath')
          ? userData['imagePath'] as String
          : '';
      if (imagePath.isNotEmpty) {
        final imageUrl = await _firebaseStorageDatasource.getFileUrl(imagePath);
        userData['imagePath'] = imageUrl;
      }
      return UserModel.fromJson(userData).toEntity();
    }
    return UserEntity(
      id: userId,
      name: '',
      lastName: '',
      documentNumber: '',
      imagePath: '',
      email: '',
      adminUid: '',
      verified: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
