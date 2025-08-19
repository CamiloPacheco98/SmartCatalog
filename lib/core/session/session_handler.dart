import 'package:firebase_auth/firebase_auth.dart';

class SessionHandler {
  static SessionHandler? _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Private constructor
  SessionHandler._();

  // Singleton instance getter
  static SessionHandler get instance {
    _instance ??= SessionHandler._();
    return _instance!;
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
