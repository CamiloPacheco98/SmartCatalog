import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

enum SplashState { initial, navigating }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial);

  void startSplashTimer() {
    Timer(const Duration(seconds: 3), () {
      emit(SplashState.navigating);
    });
  }
}
