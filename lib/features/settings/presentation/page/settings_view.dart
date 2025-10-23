import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:smart_catalog/features/settings/presentation/widgets/logout_dialog.dart';
import 'package:smart_catalog/features/settings/presentation/widgets/settings_option.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings.title'.tr())),
      body: Column(
        children: [
          const SizedBox(height: 16),
          SettingsOption(
            icon: Icons.person,
            title: 'settings.profile'.tr(),
            onTap: () => context.read<SettingsCubit>().goToProfile(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => LogoutDialog.show(
                  context,
                  onConfirm: () => context.read<SettingsCubit>().logout(),
                ),
                icon: const Icon(Icons.logout),
                label: Text('settings.logout'.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                  foregroundColor: context.colorScheme.onError,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
