import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:smart_catalog/main.dart';
import '../reset_password.dart';
import 'package:smart_catalog/core/utils/navigation_service.dart';

class ResetPasswordPage extends StatelessWidget {
  final String code;
  const ResetPasswordPage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService();
    return BlocProvider(
      create: (context) => ResetPasswordCubit(
        authRepository: getIt<AuthRepository>(),
        code: code,
      ),
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            context.goNamed(AppPaths.login);
          } else if (state is ResetPasswordError) {
            navigationService.showErrorSnackBar(state.message);
          }
        },
        child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          builder: (context, state) {
            return Stack(
              children: [
                ResetPasswordView(),
                if (state is ResetPasswordLoading) const CustomLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}
