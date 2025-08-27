import 'package:go_router/go_router.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/features/order_detail/presentation/order_detail.dart';
import 'package:smart_catalog/features/splash/presentation/page/splash_page.dart';
import 'package:smart_catalog/features/auth/presentation/page/login_page.dart';
import 'package:smart_catalog/features/tabbar/presentation/page/tabbar_page.dart';
import 'package:smart_catalog/features/cart/presentation/cart.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';

final appRouter = GoRouter(
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
      builder: (context, state) => const TabbarPage(),
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
  ],
);
