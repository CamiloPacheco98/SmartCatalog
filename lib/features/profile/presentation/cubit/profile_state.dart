part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final List<String> catalogImages;
  ProfileSuccess({required this.catalogImages});
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}

final class ProfileSuccessMessage extends ProfileState {
  final String message;

  ProfileSuccessMessage({required this.message});
}
