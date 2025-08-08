import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserCredential> login(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
