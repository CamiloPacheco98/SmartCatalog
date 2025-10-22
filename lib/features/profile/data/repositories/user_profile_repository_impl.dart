import 'package:smart_catalog/features/profile/data/source/firebase_storage_datasource.dart';
import 'package:smart_catalog/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:smart_catalog/core/session/user_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    String document,
    String imagePath,
    String email,
  ) async {
    final path = 'users/${UserSession.instance.userId}/profile.jpg';
    await _firebaseStorageDatasource.uploadFile(path, imagePath);
    await _firestore.collection('users').doc(UserSession.instance.userId).set({
      'name': name,
      'lastName': lastName,
      'document': document,
      'imagePath': path,
      'email': email,
      'adminUid': adminUid,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
      'verified': false,
    });
  }
}
