import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/constants/navigation_extra_keys.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  BuildContext? _context;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// Set the current context
  void setContext(BuildContext context) {
    _context = context;
  }

  /// Get the current context
  BuildContext? get context => _context;

  /// Get the navigator key
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Navigate to a named route
  void goNamed(String name, {Map<String, dynamic>? extra}) {
    if (_context != null) {
      _context!.goNamed(name, extra: extra);
    } else {
      debugPrint('NavigationService: Context not available for navigation to $name');
    }
  }

  /// Navigate to a path
  void go(String path, {Map<String, dynamic>? extra}) {
    if (_context != null) {
      _context!.go(path, extra: extra);
    } else {
      debugPrint('NavigationService: Context not available for navigation to $path');
    }
  }

  /// Navigate to the main app with catalog images
  void navigateToMainApp(List<String> catalogImages) {
    goNamed(
      AppPaths.tabbar,
      extra: {NavigationExtraKeys.catalogImages: catalogImages},
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    if (_context != null) {
      showTopSnackBar(
        Overlay.of(_context!),
        CustomSnackBar.error(message: message),
      );
    } else {
      debugPrint('NavigationService: Context not available for snackbar: $message');
    }
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    if (_context != null) {
      showTopSnackBar(
        Overlay.of(_context!),
        CustomSnackBar.success(message: message),
      );
    } else {
      debugPrint('NavigationService: Context not available for snackbar: $message');
    }
  }

  /// Clear the context
  void clearContext() {
    _context = null;
  }
}
