import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/widgets/custom_loading.dart';
import 'package:smart_catalog/feature/login/presentation/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state == LoginState.success) {
            debugPrint('login success');
          } else if (state == LoginState.error) {
            debugPrint('login error');
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Stack(
              children: [
                const LoginView(),
                if (state == LoginState.loading) const CustomLoading(),
              ],
            );
          },
        ),
      ),
    );
  }
}
