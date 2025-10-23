import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/constants/navigation_extra_keys.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:smart_catalog/features/profile/presentation/profile.dart';
import 'package:smart_catalog/core/utils/navigation_service.dart';
import 'package:smart_catalog/main.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/features/profile/presentation/models/user_viewmodel.dart';
import 'package:smart_catalog/core/domain/repositories/user_repository.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String adminUid;
  final bool fromSettings;
  final UserViewModel? user;

  const ProfilePage({
    super.key,
    this.email = '',
    this.adminUid = '',
    this.user,
    required this.fromSettings,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService();
    return BlocProvider(
      create: (context) => ProfileCubit(
        email: email,
        adminUid: adminUid,
        userProfileRepository: getIt<UserProfileRepository>(),
        authRepository: getIt<AuthRepository>(),
        userRepository: getIt<UserRepository>(),
      ),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            context.goNamed(
              AppPaths.tabbar,
              extra: {NavigationExtraKeys.catalogImages: state.catalogImages},
            );
          } else if (state is ProfileError) {
            navigationService.showErrorSnackBar(state.message);
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Stack(
              children: [
                ProfileView(
                  email: email,
                  fromSettings: fromSettings,
                  user: user,
                ),
                if (state is ProfileLoading) const CustomLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}
