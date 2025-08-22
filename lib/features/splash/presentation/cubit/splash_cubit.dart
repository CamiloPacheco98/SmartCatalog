import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
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
        final localCartProducts = await _repository.getLocalCartProducts();
        products = localCartProducts
            .map((e) => CartProductViewModel.fromEntity(e))
            .toList();
        CartSession.instance.initializeProducts(products);
        emit(SplashNavigating(route: AppPaths.tabbar));
      } else {
        emit(SplashNavigating(route: AppPaths.login));
      }
    });
  }
}
