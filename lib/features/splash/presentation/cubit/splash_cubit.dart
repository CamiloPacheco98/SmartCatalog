import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/constants/navigation_extra_keys.dart';
import 'package:smart_catalog/core/constants/hive_constants.dart';
import 'package:smart_catalog/core/errors/failures.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/session/catalog_session.dart';
import 'package:smart_catalog/core/session/orders_session.dart';
import 'package:smart_catalog/core/session/user_session.dart';
import 'package:smart_catalog/core/utils/deep_link_handler.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:smart_catalog/features/splash/domain/repositories/splash_repository.dart';
import 'package:smart_catalog/core/domain/entities/user_entity.dart';
import 'package:smart_catalog/core/domain/repositories/user_repository.dart';
import 'package:smart_catalog/features/settings/domain/repositories/settings_repository.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository _repository;
  final UserRepository _userRepository;
  final SettingsRepository _settingsRepository;
  SplashCubit({
    required SplashRepository repository,
    required UserRepository userRepository,
    required SettingsRepository settingsRepository,
  }) : _repository = repository,
       _userRepository = userRepository,
       _settingsRepository = settingsRepository,
       super(SplashInitial());

  Future<void> startSplashTimer() async {
    final deepLinkHandler = DeepLinkHandler();
    await deepLinkHandler.initialize();
    if (deepLinkHandler.navigationHandled) {
      debugPrint('Navigation handled by deep link handler');
      return;
    }
    final isUserLoggedIn = UserSession.instance.isLoggedIn;
    if (isUserLoggedIn) {
      final isFirstLaunch = await _isFirstLaunch();
      final userInitialized = await _initializeUser(
        isFirstLaunch: isFirstLaunch,
      );
      if (!userInitialized) {
        await _logout();
        // 🔁 Retry once after logout
        Future.delayed(const Duration(milliseconds: 300), startSplashTimer);
        return; // stop current flow
      }
      await _initializeCart(isFirstLaunch);
      await _initializeOrders(isFirstLaunch);
      final catalog = await _repository.getCatalog();
      CatalogSession.instance.setCatalog(catalog);
      final catalogImages = catalog?.downloadUrls ?? [];
      await setIsFirstLaunch(false);
      emit(
        SplashNavigating(
          route: AppPaths.tabbar,
          arguments: {NavigationExtraKeys.catalogImages: catalogImages},
        ),
      );
    } else {
      emit(SplashNavigating(route: AppPaths.login, arguments: {}));
    }
  }

  Future<bool> _isFirstLaunch() async =>
      _repository.getAppSettings(HiveKeys.isFirstLaunch, defaultValue: true);

  Future<void> setIsFirstLaunch(bool value) async {
    await _repository.saveAppSettings(HiveKeys.isFirstLaunch, value);
  }

  Future<void> _initializeOrders(bool isFirstLaunch) async {
    final isUserVerified = UserSession.instance.user.verified;
    if (!isUserVerified) {
      return;
    }
    if (isFirstLaunch) {
      final orders = await _repository.getOrders();
      final ordersMap = Map.fromEntries(orders.map((e) => MapEntry(e.id, e)));
      await _repository.saveLocalOrders(ordersMap);
      OrdersSession.instance.initializeOrders(ordersMap.values.toList());
    } else {
      final localOrders = await _repository.getLocalOrders();
      OrdersSession.instance.initializeOrders(localOrders);
    }
  }

  Future<bool> _initializeUser({required bool isFirstLaunch}) async {
    UserEntity? user;

    // Fetch user data depending on whether it's the first launch
    final result = isFirstLaunch ? await getUser() : await getLocalUser();

    // If fetching failed, stop early
    if (result.isLeft()) {
      return false;
    }

    final userResult = result.getOrElse(() => UserEntity.empty());

    // Extra validation to ensure user data is valid
    if (userResult.id.isEmpty) {
      return false;
    }

    // Save the user locally only on the first launch
    if (isFirstLaunch) {
      await saveLocalUser(userResult);
    }

    // Initialize the user session
    user = userResult;
    UserSession.instance.initializeUser(user);

    return true;
  }

  Future<Either<Failure, UserEntity>> getUser() async {
    return _userRepository.getUser(UserSession.instance.userId);
  }

  Future<Either<Failure, UserEntity>> getLocalUser() async {
    return _userRepository.getLocalUser();
  }

  Future<void> saveLocalUser(UserEntity user) async {
    return _userRepository.saveLocalUser(user);
  }

  Future<void> _initializeCart(bool isFirstLaunch) async {
    List<CartProductViewModel> products = [];
    if (isFirstLaunch) {
      final cartProducts = await _repository.getCartProducts();
      await _repository.saveLocalCartProducts(
        cartProducts?.values.toList() ?? [],
      );
      products =
          cartProducts?.values
              .map((e) => CartProductViewModel.fromEntity(e))
              .toList() ??
          [];
    } else {
      final localCartProducts = await _repository.getLocalCartProducts();
      products = localCartProducts
          .map((e) => CartProductViewModel.fromEntity(e))
          .toList();
    }
    CartSession.instance.initializeProducts(products);
  }

  Future<void> _logout() async {
    await _settingsRepository.logout();
  }
}
