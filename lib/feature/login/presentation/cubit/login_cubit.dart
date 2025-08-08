import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/feature/login/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial);

  void login({required String email, required String password}) {
    emit(LoginState.loading);
    Future.delayed(const Duration(seconds: 2), () {
      emit(LoginState.error);
    });
  }
}
