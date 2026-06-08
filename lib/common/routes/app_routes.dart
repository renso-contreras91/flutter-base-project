import 'package:go_router/go_router.dart';
import 'package:yala/presentation/dashboard/dashboard_screen.dart';
import 'package:yala/presentation/launcher/launcher_screen.dart';
import 'package:yala/presentation/sign_in/sign_in_screen.dart';

abstract final class AppRoutes {
  static const launcher = '/';
  static const signIn = '/sign-in';
  static const dashboard = '/dashboard';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.launcher,
  routes: [
    GoRoute(
      path: AppRoutes.launcher,
      builder: (context, state) => const LauncherScreen(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
