import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;
  final String _code;
  ResetPasswordCubit({
    required AuthRepository authRepository,
    required String code,
  }) : _authRepository = authRepository,
       _code = code,
       super(ResetPasswordInitial());

  void resetPassword({required String newPassword}) {
    emit(ResetPasswordLoading());
    _authRepository
        .resetPassword(_code, newPassword)
        .then((value) {
          emit(ResetPasswordSuccess());
        })
        .catchError((error) {
          debugPrint('resetPassword Error: ${error.toString()}');
          emit(ResetPasswordError(message: 'errors.reset_password_error'.tr()));
        });
  }
}
