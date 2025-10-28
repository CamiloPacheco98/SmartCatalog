part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsNavigate extends SettingsState {
  final String route;
  final Map<String, dynamic>? extra;
  final NavigateMethod method;
  SettingsNavigate(
    this.route, {
    this.extra = const {},
    this.method = NavigateMethod.pushNamed,
  });
}
