import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/session/orders_session.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(LoginInitial());

  void login({required String email, required String password}) {
    emit(LoginLoading());
    _authRepository
        .login(email, password)
        .then((value) async {
          await _initCartProducts();
          await _initOrders();
          final catalogImages = await _initCatalogImages();
          emit(LoginSuccess(catalogImages: catalogImages));
        })
        .catchError((error) {
          debugPrint('login cubit Error: ${error.toString()}');
          emit(LoginError(message: 'errors.login_error'.tr()));
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

  Future<List<String>> _initCatalogImages() async {
    try {
      return await _authRepository.getCatalogImages();
    } catch (error) {
      debugPrint('initCatalogImages Error: ${error.toString()}');
      return [];
    }
  }
}
