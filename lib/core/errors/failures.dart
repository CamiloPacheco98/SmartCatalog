import 'package:easy_localization/easy_localization.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure([String? message])
    : super(message ?? 'errors.user_not_found'.tr());
}
