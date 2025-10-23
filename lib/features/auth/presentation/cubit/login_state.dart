part of 'login_cubit.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginSuccess extends LoginState {
  final List<String> catalogImages;
  const LoginSuccess({required this.catalogImages});
}

final class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginShowSuccessMessage extends LoginState {
  final String message;
  const LoginShowSuccessMessage({required this.message});
}
