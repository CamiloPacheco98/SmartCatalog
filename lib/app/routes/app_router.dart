  import 'package:go_router/go_router.dart';
  import 'package:smart_catalog/app/routes/app_path.dart';
  import 'package:smart_catalog/features/splash/presentation/page/splash_page.dart';
  import 'package:smart_catalog/features/auth/presentation/page/login_page.dart';

final appRouter = GoRouter(
  initialLocation: AppPaths.splash,
  routes: [
    GoRoute(
      path: AppPaths.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppPaths.login,
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
