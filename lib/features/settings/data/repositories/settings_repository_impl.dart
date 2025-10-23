import 'package:hive/hive.dart';
import 'package:smart_catalog/features/settings/domain/repositories/settings_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required FirebaseAuth auth,
    required Box<Map> cartBox,
    required Box<Map> ordersBox,
    required Box<Map> userBox,
  }) : _auth = auth,
       _cartBox = cartBox,
       _ordersBox = ordersBox,
       _userBox = userBox;

  final FirebaseAuth _auth;
  final Box<Map> _cartBox;
  final Box<Map> _ordersBox;
  final Box<Map> _userBox;

  @override
  Future<void> logout() async {
    await _clearCache();
    await _auth.signOut();
  }

  Future<void> _clearCache() async {
    await _cartBox.clear();
    await _ordersBox.clear();
    await _userBox.clear();
  }
}
