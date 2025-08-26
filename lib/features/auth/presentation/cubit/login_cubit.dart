import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/session/orders_session.dart';
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
        .then((value) async {
          await _initCartProducts();
          await _initOrders();
          emit(LoginState.success);
        })
        .catchError((error) {
          debugPrint('login cubit Error: ${error.toString()}');
          emit(LoginState.error);
        });
  }

  Future<void> _initCartProducts() async {
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

  Future<void> _initOrders() async {
    try {
      final orders = await _authRepository.getOrders();
      final ordersMap = Map.fromEntries(orders.map((e) => MapEntry(e.id, e)));
      _authRepository.saveLocalOrders(ordersMap);
      OrdersSession.instance.initializeOrders(ordersMap.values.toList());
    } catch (error) {
      debugPrint('initOrders Error: ${error.toString()}');
    }
  }
}
