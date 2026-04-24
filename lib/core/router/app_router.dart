import 'package:flutter_very_good_example/core/config/app_config.dart'
    show AppConfig, AppFlavor;
import 'package:flutter_very_good_example/core/router/app_routes.dart';
import 'package:flutter_very_good_example/core/router/pages/access_denied_page.dart';
import 'package:flutter_very_good_example/core/router/pages/error_page.dart';
import 'package:flutter_very_good_example/core/router/pages/not_found_page.dart';
import 'package:flutter_very_good_example/features/counter/counter.dart';
import 'package:flutter_very_good_example/features/home/home.dart';
import 'package:flutter_very_good_example/features/splash/splash.dart';
import 'package:go_router/go_router.dart';

/// Grafo de navegación. Nuevas rutas: import explícito de la página.
GoRouter createAppRouter(AppConfig config) {
  return GoRouter(
    debugLogDiagnostics: config.flavor == AppFlavor.development,
    initialLocation: AppRoutes.splash.path,
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.counter.path,
        name: AppRoutes.counter.name,
        builder: (context, state) => const CounterPage(),
      ),
      GoRoute(
        path: AppRoutes.error.path,
        name: AppRoutes.error.name,
        builder: (context, state) {
          final msg = state.uri.queryParameters['message'];
          return ErrorPage(message: msg);
        },
      ),
      GoRoute(
        path: AppRoutes.accessDenied.path,
        name: AppRoutes.accessDenied.name,
        builder: (context, state) => const AccessDeniedPage(),
      ),
    ],
  );
}
