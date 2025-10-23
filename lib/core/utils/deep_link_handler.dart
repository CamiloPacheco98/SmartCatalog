import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/utils/navigation_service.dart';
import 'package:smart_catalog/core/constants/navigation_extra_keys.dart';

class DeepLinkHandler {
  static final DeepLinkHandler _instance = DeepLinkHandler._internal();
  factory DeepLinkHandler() => _instance;
  DeepLinkHandler._internal();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigationService = NavigationService();
  bool _navigationHandled = false;
  bool _handledInitialLink = false;

  bool get navigationHandled => _navigationHandled;

  /// Initialize the deep link handler
  Future<void> initialize() async {
    await handleInitialLink();
    _startListeningLinks();
  }

  Future<void> handleInitialLink() async {
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        await _handleIncomingLink(initialLink);
        _handledInitialLink = true;
      }
    } catch (e) {
      debugPrint('Error getting initial link: $e');
    }
  }

  void _startListeningLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen(
      _handleIncomingLink,
      onError: (err) {
        debugPrint('Deep link error: $err');
      },
    );
  }

  /// Handle incoming deep links
  Future<void> _handleIncomingLink(Uri uri) async {
    if (_handledInitialLink) {
      return;
    }

    // Check if this is a Firebase auth link
    if (_isFirebaseAuthLink(uri)) {
      await _handleFirebaseAuthLink(uri);
    }
  }

  /// Check if the URI is a Firebase authentication link
  bool _isFirebaseAuthLink(Uri uri) {
    // Check if the link contains Firebase auth parameters
    return uri.queryParameters.containsKey('link') ||
        uri.queryParameters.containsKey('oobCode') ||
        uri.path.contains('/__/auth/links');
  }

  /// Handle Firebase authentication link
  Future<void> _handleFirebaseAuthLink(Uri uri) async {
    try {
      // Check if this is a sign-in with email link
      if (_auth.isSignInWithEmailLink(uri.toString())) {
        await _processEmailLinkSignIn(uri);
      } else if (_isResetPasswordLink(uri)) {
        await _handleResetPasswordLink(uri);
      } else {
        _navigationService.showErrorSnackBar(
          'errors.failed_to_process_link'.tr(),
        );
      }
    } catch (e) {
      _navigationService.showErrorSnackBar(
        'errors.failed_to_process_link'.tr(),
      );
    }
  }

  /// Process email link sign-in
  Future<void> _processEmailLinkSignIn(Uri uri) async {
    try {
      // Get the email from the URI
      final queryParams = parseAuthLink(uri);

      final storedEmail = queryParams['email']?.trim() ?? '';
      final adminUid = queryParams['adminUid']?.trim() ?? '';

      if (storedEmail.isEmpty) {
        _navigationService.showErrorSnackBar('errors.email_not_found'.tr());
        return;
      }

      // Sign in with the email link
      final UserCredential userCredential = await _auth.signInWithEmailLink(
        email: storedEmail,
        emailLink: uri.toString(),
      );

      if (userCredential.user != null) {
        // Navigate to profile screen
        await _navigateToProfile(email: storedEmail, adminUid: adminUid);
      }
    } catch (e) {
      debugPrint('Error processing email link sign-in: $e');
      _navigationService.showErrorSnackBar(
        'errors.failed_to_sign_in_with_email_link'.tr(),
      );
    }
  }

  Future<void> _handleResetPasswordLink(Uri uri) async {
    try {
      final innerUri = _getInnerUri(uri);
      if (innerUri == null) return;
      final oobCode = innerUri.queryParameters['oobCode'];
      if (oobCode == null) return;
      _navigationHandled = true;
      _navigationService.goNamed(
        AppPaths.resetPassword,
        extra: {NavigationExtraKeys.code: oobCode},
      );
    } catch (e) {
      debugPrint('Error handling reset password link: $e');
      _navigationService.showErrorSnackBar(
        'errors.failed_to_process_reset_password_link'.tr(),
      );
    }
  }

  Map<String, String?> parseAuthLink(Uri uri) {
    final innerUri = _getInnerUri(uri);
    if (innerUri == null) return {};

    // 3️⃣ Get the "continueUrl" parameter (still encoded)
    final continueUrl = innerUri.queryParameters['continueUrl'];
    if (continueUrl == null) return {};

    // 4️⃣ Decode and parse the continueUrl to access final query parameters
    final decodedContinue = Uri.decodeFull(continueUrl);
    final continueUri = Uri.parse(decodedContinue);

    // 5️⃣ Extract adminUid and email
    final adminUid = continueUri.queryParameters['adminUid'];
    final email = continueUri.queryParameters['email'];

    return {'adminUid': adminUid, 'email': email};
  }

  bool _isResetPasswordLink(Uri uri) {
    final innerUri = _getInnerUri(uri);
    if (innerUri == null) return false;
    return innerUri.queryParameters['mode'] == 'resetPassword';
  }

  Uri? _getInnerUri(Uri uri) {
    // 1️⃣ Get the "link" parameter (contains another nested URL)
    final innerLink = uri.queryParameters['link'];
    if (innerLink == null) return null;

    // 2️⃣ Parse the inner Firebase Auth action URL
    return Uri.parse(innerLink);
  }

  /// Navigate to the profile screen
  Future<void> _navigateToProfile({
    required String email,
    required String adminUid,
  }) async {
    _navigationHandled = true;
    _navigationService.goNamed(
      AppPaths.createProfile,
      extra: {
        NavigationExtraKeys.email: email,
        NavigationExtraKeys.adminUid: adminUid,
      },
    );
  }

  /// Dispose the deep link handler
  void dispose() {
    _linkSubscription?.cancel();
  }
}
