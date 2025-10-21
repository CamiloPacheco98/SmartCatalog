import 'package:flutter/material.dart';
import 'package:smart_catalog/app/routes/app_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// Get the navigator key
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Navigate to a named route
  void goNamed(String name, {Map<String, dynamic>? extra}) {
    appRouter.goNamed(name, extra: extra);
  }

  /// Navigate to a path
  void go(String path, {Map<String, dynamic>? extra}) {
    appRouter.go(path, extra: extra);
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;
    showTopSnackBar(overlay, CustomSnackBar.error(message: message));
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;
    showTopSnackBar(overlay, CustomSnackBar.success(message: message));
  }
}
