import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback? onConfirm;

  const LogoutDialog({super.key, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'settings.logout'.tr(),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'settings.logout_confirmation'.tr(),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text('settings.cancel'.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            context.pop();
            onConfirm?.call();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.error,
            foregroundColor: context.colorScheme.onError,
          ),
          child: Text('settings.confirm'.tr()),
        ),
      ],
    );
  }

  static Future<void> show(BuildContext context, {VoidCallback? onConfirm}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog(onConfirm: onConfirm);
      },
    );
  }
}
