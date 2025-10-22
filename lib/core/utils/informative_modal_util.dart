import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';

/// Utility class for displaying informative modals with customizable content
/// and action buttons
class InformativeModalUtil {
  /// Shows an informative modal dialog with title, subtitle, and action buttons
  ///
  /// [context] - The build context to show the modal
  /// [title] - The main title of the modal
  /// [subtitle] - The subtitle/description text
  /// [acceptText] - Text for the accept button (default: 'Accept')
  /// [rejectText] - Text for the reject button (default: 'Cancel')
  /// [onAccept] - Callback function when accept button is pressed
  /// [onReject] - Callback function when reject button is pressed
  /// [icon] - Optional icon to display in the modal (default: info icon)
  /// [isDismissible] - Whether the modal can be dismissed by tapping outside (default: true)
  static Future<void> showInformativeModal({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? acceptText,
    String? rejectText,
    VoidCallback? onAccept,
    VoidCallback? onReject,
    IconData? icon,
    bool isDismissible = true,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Informative icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon ?? Icons.info_outline,
                  size: 32,
                  color: context.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                title,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                subtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  // Reject button
                  if (rejectText != null)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          context.pop();
                          onReject?.call();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          foregroundColor: context.colorScheme.primary,
                          side: BorderSide(color: context.colorScheme.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(rejectText),
                      ),
                    ),
                  const SizedBox(width: 12),

                  // Accept button
                  if (acceptText != null)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop();
                          onAccept?.call();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(acceptText),
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
