import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/features/settings/domain/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository) : super(SettingsInitial());
  final SettingsRepository _settingsRepository;

  Future<void> logout() async {
    emit(SettingsLoading());
    await _settingsRepository.logout();
    emit(SettingsNavigate(AppPaths.login));
  }
}
