import 'package:smart_catalog/core/data/source/firebase_storage_datasource.dart';
import 'package:smart_catalog/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:smart_catalog/core/session/user_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_catalog/core/constants/firestore_collections.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final FirebaseStorageDatasource _firebaseStorageDatasource;
  final FirebaseFirestore _firestore;
  UserProfileRepositoryImpl({
    required FirebaseStorageDatasource firebaseStorageDatasource,
    required FirebaseFirestore firestore,
  }) : _firebaseStorageDatasource = firebaseStorageDatasource,
       _firestore = firestore;
  @override
  Future<void> createProfile(
    String adminUid,
    String name,
    String lastName,
    String documentNumber,
    String imagePath,
    String email,
  ) async {
    final path = 'users/${UserSession.instance.userId}/profile.jpg';
    if (imagePath.isNotEmpty) {
      await _firebaseStorageDatasource.uploadFile(path, imagePath);
    }
    await _firestore
        .collection(FirestoreCollections.users)
        .doc(UserSession.instance.userId)
        .set({
          'id': UserSession.instance.userId,
          'name': name,
          'lastName': lastName,
          'documentNumber': documentNumber,
          'imagePath': path,
          'email': email,
          'adminUid': adminUid,
          'createdAt': DateTime.now(),
          'updatedAt': DateTime.now(),
          'verified': false,
          'type': 'user',
        });
  }

  @override
  Future<void> updateProfile(
    String name,
    String lastName,
    String documentNumber,
    String imagePath,
  ) async {
    final userId = UserSession.instance.userId;
    final path = 'users/$userId/profile.jpg';
    if (imagePath.isNotEmpty) {
      await _firebaseStorageDatasource.uploadFile(path, imagePath);
    }
    await _firestore.collection(FirestoreCollections.users).doc(userId).update({
      'name': name,
      'lastName': lastName,
      'documentNumber': documentNumber,
      'imagePath': path,
      'updatedAt': DateTime.now(),
    });
  }
}
