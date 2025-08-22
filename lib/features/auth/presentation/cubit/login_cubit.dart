import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:smart_catalog/features/auth/presentation/cubit/login_state.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';

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
          initCartProducts();
          emit(LoginState.success);
        })
        .catchError((error) {
          debugPrint('login cubit Error: ${error.toString()}');
          emit(LoginState.error);
        });
  }

  Future<void> initCartProducts() async {
    try {
      final products = await _authRepository.getCartProducts();
      _authRepository.saveLocalCartProducts(products?.values.toList() ?? []);
      final productsViewModel = products?.values
          .map((e) => CartProductViewModel.fromEntity(e))
          .toList();
      CartSession.instance.initializeProducts(productsViewModel ?? []);
    } catch (error) {
      debugPrint('initCartProducts Error: ${error.toString()}');
    }
  }
}
