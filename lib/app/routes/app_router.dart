import 'package:go_router/go_router.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/constants/navigation_extra_keys.dart';
import 'package:smart_catalog/features/order_detail/presentation/order_detail.dart';
import 'package:smart_catalog/features/splash/presentation/page/splash_page.dart';
import 'package:smart_catalog/features/auth/presentation/page/login_page.dart';
import 'package:smart_catalog/features/tabbar/presentation/page/tabbar_page.dart';
import 'package:smart_catalog/features/cart/presentation/cart.dart';
import 'package:smart_catalog/features/profile/presentation/profile.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/core/utils/navigation_service.dart';

final appRouter = GoRouter(
  navigatorKey: NavigationService().navigatorKey,
  initialLocation: AppPaths.splash,
  routes: [
    GoRoute(
      path: AppPaths.splash,
      name: AppPaths.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: AppPaths.login,
      path: AppPaths.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: AppPaths.tabbar,
      path: AppPaths.tabbar,
      builder: (context, state) {
        try {
          final arguments = state.extra as Map<String, dynamic>;
          final imageUrls =
              arguments[NavigationExtraKeys.catalogImages] as List<String>;
          return TabbarPage(imageUrls: imageUrls);
        } catch (e) {
          return const TabbarPage(imageUrls: []);
        }
      },
    ),
    GoRoute(
      name: AppPaths.cart,
      path: AppPaths.cart,
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      name: AppPaths.orderDetail,
      path: AppPaths.orderDetail,
      builder: (context, state) {
        final order = state.extra as OrderEntity;
        return OrderDetailPage(order: order);
      },
    ),
    GoRoute(
      name: AppPaths.profile,
      path: AppPaths.profile,
      builder: (context, state) {
        try {
          final arguments = state.extra as Map<String, dynamic>;
          final email = arguments[NavigationExtraKeys.email] as String;
          final adminUid = arguments[NavigationExtraKeys.adminUid] as String;
          return ProfilePage(email: email, adminUid: adminUid);
        } catch (e) {
          return const ProfilePage(email: '', adminUid: '');
        }
      },
    ),
  ],
);
