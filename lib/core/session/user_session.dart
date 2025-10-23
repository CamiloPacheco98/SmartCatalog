import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_catalog/core/domain/entities/user_entity.dart';

class UserSession {
  static UserSession? _instance;
  late final UserEntity _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Private constructor
  UserSession._();

  UserEntity get user => _user;

  void initializeUser(UserEntity user) {
    _user = user;
  }

  // Singleton instance getter
  static UserSession get instance {
    _instance ??= UserSession._();
    return _instance!;
  }

  bool get isLoggedIn => _auth.currentUser != null;

  String get userId => _auth.currentUser?.uid ?? '';
}
