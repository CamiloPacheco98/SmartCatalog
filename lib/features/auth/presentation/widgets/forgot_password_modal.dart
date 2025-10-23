import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/utils/validators.dart';

class ForgotPasswordModal {
  static Future<void> show({
    required BuildContext context,
    required Function(String email) onAccept,
  }) async {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'forgot_password.title'.tr(),
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'forgot_password.subtitle'.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Email
              Form(
                key: formKey,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'forgot_password.email'.tr(),
                  ),
                  validator: Validators.email,
                ),
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  // Accept button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          onAccept(emailController.text.trim());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('forgot_password.reset_password'.tr()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
