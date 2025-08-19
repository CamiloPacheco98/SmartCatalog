import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/session/session_handler.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplashTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (SessionHandler.instance.isLoggedIn()) {
        emit(SplashNavigating(route: AppPaths.tabbar));
      } else {
        emit(SplashNavigating(route: AppPaths.login));
      }
    });
  }
}
