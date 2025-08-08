import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:smart_catalog/features/splash/presentation/splash.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial);

  void startSplashTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      emit(SplashState.navigating);
    });
  }
}
