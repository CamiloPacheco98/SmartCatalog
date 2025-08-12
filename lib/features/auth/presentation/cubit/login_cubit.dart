import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:smart_catalog/features/auth/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(LoginState.initial);

  void login({required String email, required String password}) {
    emit(LoginState.loading);
    _authRepository
        .login(email, password)
        .then((value) {
          emit(LoginState.success);
        })
        .catchError((error) {
          debugPrint('login cubit Error: ${error.toString()}');
          emit(LoginState.error);
        });
  }
}
