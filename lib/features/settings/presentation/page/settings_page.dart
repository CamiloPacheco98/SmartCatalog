import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/main.dart';
import 'package:smart_catalog/features/settings/domain/repositories/settings_repository.dart';
import 'package:smart_catalog/features/settings/presentation/settings.dart';
import 'package:smart_catalog/core/enums/navigate_method.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(getIt<SettingsRepository>()),
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsNavigate) {
            switch (state.method) {
              case NavigateMethod.pushNamed:
                context.pushNamed(state.route, extra: state.extra);
                break;
              case NavigateMethod.goNamed:
                context.goNamed(state.route, extra: state.extra);
                break;
            }
          }
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Stack(
              children: [
                const SettingsView(),
                if (state is SettingsLoading) const CustomLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}
