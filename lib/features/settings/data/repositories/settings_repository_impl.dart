import 'package:hive/hive.dart';
import 'package:smart_catalog/features/settings/domain/repositories/settings_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required FirebaseAuth auth}) : _auth = auth;

  final FirebaseAuth _auth;

  @override
  Future<void> logout() async {
    await Hive.deleteFromDisk();
    await _auth.signOut();
  }
}
