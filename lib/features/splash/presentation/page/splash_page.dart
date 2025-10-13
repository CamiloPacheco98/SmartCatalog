import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/features/splash/domain/repositories/splash_repository.dart';
import 'package:smart_catalog/features/splash/presentation/splash.dart';
import 'package:smart_catalog/main.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashCubit(repository: getIt<SplashRepository>())
            ..startSplashTimer(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigating) {
            context.goNamed(state.route);
            if (state.arguments.isNotEmpty) {
              context.goNamed(state.route, extra: state.arguments);
            }
          }
        },
        child: const SplashView(),
      ),
    );
  }
}
