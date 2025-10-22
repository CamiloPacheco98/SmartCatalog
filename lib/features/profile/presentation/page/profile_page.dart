import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:smart_catalog/features/profile/presentation/profile.dart';
import 'package:smart_catalog/core/utils/navigation_service.dart';
import 'package:smart_catalog/main.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String adminUid;
  const ProfilePage({super.key, required this.email, required this.adminUid});

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService();
    return BlocProvider(
      create: (context) => ProfileCubit(
        email: email,
        adminUid: adminUid,
        userProfileRepository: getIt<UserProfileRepository>(),
      ),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            // TODO: Navigate to the next screen
          } else if (state is ProfileError) {
            navigationService.showErrorSnackBar(state.message);
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Stack(
              children: [
                const ProfileView(),
                if (state is ProfileLoading) const CustomLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}
