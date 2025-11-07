import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/domain/entities/user_entity.dart';
import 'package:smart_catalog/core/session/catalog_session.dart';
import 'package:smart_catalog/core/session/user_session.dart';
import 'package:smart_catalog/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:smart_catalog/core/domain/repositories/user_repository.dart';
import 'package:smart_catalog/features/profile/presentation/models/user_viewmodel.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final String _email;
  final String _adminUid;
  final UserProfileRepository _userProfileRepository;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  ProfileCubit({
    required String email,
    required String adminUid,
    required UserProfileRepository userProfileRepository,
    required AuthRepository authRepository,
    required UserRepository userRepository,
  }) : _email = email,
       _adminUid = adminUid,
       _userProfileRepository = userProfileRepository,
       _authRepository = authRepository,
       _userRepository = userRepository,
       super(ProfileInitial());

  Future<void> createProfile({
    required String name,
    required String lastName,
    required String documentNumber,
    String? imagePath,
  }) async {
    emit(ProfileLoading());
    // Simulate API
    try {
      await _userProfileRepository.createProfile(
        _adminUid,
        name,
        lastName,
        documentNumber,
        imagePath ?? '',
        _email,
      );
      await _initUser();
      final catalogImages = await _initCatalogImages();
      emit(ProfileSuccess(catalogImages: catalogImages));
    } catch (error) {
      debugPrint('createProfile Error: ${error.toString()}');
      emit(ProfileError(message: 'errors.create_profile_error'.tr()));
    }
  }

  void resetState() {
    emit(ProfileInitial());
  }

  Future<List<String>> _initCatalogImages() async {
    try {
      final catalog = await _authRepository.getCatalog();
      CatalogSession.instance.setCatalog(catalog);
      return catalog?.downloadUrls ?? [];
    } catch (error) {
      debugPrint('initCatalogImages Error: ${error.toString()}');
      return [];
    }
  }

  Future<void> _initUser() async {
    final user = await getUser();
    await saveLocalUser(user);
    UserSession.instance.initializeUser(user);
  }

  Future<UserEntity> getUser() async {
    final result = await _userRepository.getUser(UserSession.instance.userId);
    if (result.isLeft()) {
      return UserEntity.empty();
    }
    return result.getOrElse(() => UserEntity.empty());
  }

  Future<void> saveLocalUser(UserEntity user) async {
    return _userRepository.saveLocalUser(user);
  }

  Future<UserViewModel?> updateProfile({
    required String name,
    required String lastName,
    required String documentNumber,
    String? imagePath,
  }) async {
    emit(ProfileLoading());
    try {
      await _userProfileRepository.updateProfile(
        name,
        lastName,
        documentNumber,
        imagePath ?? '',
      );
      final user = await getUser();
      await saveLocalUser(user);
      UserSession.instance.initializeUser(user);
      emit(
        ProfileSuccessMessage(message: 'success.update_profile_success'.tr()),
      );
      return UserViewModel.fromEntity(user);
    } catch (error) {
      debugPrint('updateProfile Error: ${error.toString()}');
      emit(ProfileError(message: 'errors.update_profile_error'.tr()));
      return null;
    }
  }
}
