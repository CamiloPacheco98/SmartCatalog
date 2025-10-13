import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/constants/navigation_extra_keys.dart';
import 'package:smart_catalog/core/constants/hive_constants.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/session/orders_session.dart';
import 'package:smart_catalog/core/session/user_session.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:smart_catalog/features/splash/domain/repositories/splash_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository _repository;
  SplashCubit({required SplashRepository repository})
    : _repository = repository,
      super(SplashInitial());

  void startSplashTimer() {
    Future.delayed(const Duration(seconds: 3), () async {
      List<CartProductViewModel> products = [];
      if (UserSession.instance.isLoggedIn) {
        final isFirstLaunch = await _repository.getAppSettings(
          HiveKeys.isFirstLaunch,
          defaultValue: true,
        );
        if (isFirstLaunch) {
          final cartProducts = await _repository.getCartProducts();
          await _repository.saveLocalCartProducts(
            cartProducts?.values.toList() ?? [],
          );
          final orders = await _repository.getOrders();
          final ordersMap = Map.fromEntries(
            orders.map((e) => MapEntry(e.id, e)),
          );
          await _repository.saveLocalOrders(ordersMap);
          await _repository.saveAppSettings(HiveKeys.isFirstLaunch, false);
        }
        final localCartProducts = await _repository.getLocalCartProducts();
        products = localCartProducts
            .map((e) => CartProductViewModel.fromEntity(e))
            .toList();
        CartSession.instance.initializeProducts(products);
        final localOrders = await _repository.getLocalOrders();
        OrdersSession.instance.initializeOrders(localOrders);
        final catalogImages = await _repository.getCatalogImages();
        emit(
          SplashNavigating(
            route: AppPaths.tabbar,
            arguments: {NavigationExtraKeys.catalogImages: catalogImages},
          ),
        );
      } else {
        emit(SplashNavigating(route: AppPaths.login, arguments: {}));
      }
    });
  }
}
