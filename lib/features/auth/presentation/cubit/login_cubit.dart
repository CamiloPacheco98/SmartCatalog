import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/domain/entities/user_entity.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/session/catalog_session.dart';
import 'package:smart_catalog/core/session/orders_session.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:smart_catalog/core/domain/repositories/user_repository.dart';
import 'package:smart_catalog/core/session/user_session.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  LoginCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       super(LoginInitial());

  void showResetSuccess(bool showResetSuccess) {
    if (showResetSuccess) {
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(
          LoginShowSuccessMessage(
            message: 'success.reset_password_success'.tr(),
          ),
        );
      });
    }
  }

  void login({required String email, required String password}) {
    emit(LoginLoading());
    _authRepository
        .login(email, password)
        .then((value) async {
          await _initCartProducts();
          await _initUser();
          await _initOrders();
          final catalogImages = await _initCatalogImages();
          emit(LoginSuccess(catalogImages: catalogImages));
        })
        .catchError((error) {
          debugPrint('login cubit Error: ${error.toString()}');
          emit(LoginError(message: 'errors.login_error'.tr()));
        });
  }

  void forgotPassword(String email) {
    emit(LoginLoading());
    _authRepository.forgotPassword(email).then((value) {
      emit(LoginShowSuccessMessage(message: 'success.forgot_password'.tr()));
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
    if (!UserSession.instance.user.verified) {
      return;
    }
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
      final catalog = await _authRepository.getCatalog();
      CatalogSession.instance.setCatalog(catalog);
      return catalog?.downloadUrls ?? [];
    } catch (error) {
      debugPrint('initCatalogImages Error: ${error.toString()}');
      return [];
    }
  }

  Future<void> _initUser() async {
    final user = await getUser();
    await saveLocalUser(user);
    UserSession.instance.initializeUser(user);
  }

  Future<UserEntity> getUser() async {
    final result = await _userRepository.getUser(UserSession.instance.userId);
    if (result.isLeft()) {
      return UserEntity.empty();
    }
    return result.getOrElse(() => UserEntity.empty());
  }

  Future<void> saveLocalUser(UserEntity user) async {
    return _userRepository.saveLocalUser(user);
  }
}
