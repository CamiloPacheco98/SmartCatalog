part of 'splash_cubit.dart';

@immutable
sealed class SplashState {
  const SplashState();
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashNavigating extends SplashState {
  final String route;
  final Map<String, dynamic> arguments;
  const SplashNavigating({required this.route, required this.arguments});
}
