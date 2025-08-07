import 'package:easy_localization/easy_localization.dart';

class Validators {
  Validators._();

  static final RegExp _emailRegExp =
      RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');

  static String? requiredField(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.required'.tr(args: [fieldName]);
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = requiredField(value, fieldName: 'email'.tr());
    if (requiredError != null) return requiredError;
    final trimmed = value!.trim();
    if (!_emailRegExp.hasMatch(trimmed)) {
      return 'validation.email_invalid'.tr();
    }
    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    final requiredError = requiredField(value, fieldName: 'password'.tr());
    if (requiredError != null) return requiredError;
    if (value!.length < minLength) {
      return 'validation.password_min'.tr(args: [minLength.toString()]);
    }
    return null;
  }
}


