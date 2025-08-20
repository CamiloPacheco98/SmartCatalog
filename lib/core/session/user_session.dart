import 'package:firebase_auth/firebase_auth.dart';

class UserSession {
  static UserSession? _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Private constructor
  UserSession._();

  // Singleton instance getter
  static UserSession get instance {
    _instance ??= UserSession._();
    return _instance!;
  }

  bool get isLoggedIn => _auth.currentUser != null;
}
