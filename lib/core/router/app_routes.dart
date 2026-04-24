/// Definición de ruta: [path] y [name] juntos (deep links y `context.goNamed`).
class AppRoute {
  const AppRoute({required this.path, required this.name});

  final String path;
  final String name;
}

/// Catálogo de rutas de la app.
abstract final class AppRoutes {
  static const AppRoute splash = AppRoute(
    path: '/splash',
    name: 'splash',
  );

  static const AppRoute home = AppRoute(
    path: '/',
    name: 'home',
  );

  static const AppRoute counter = AppRoute(
    path: '/counter',
    name: 'counter',
  );

  static const AppRoute error = AppRoute(
    path: '/error',
    name: 'error',
  );

  static const AppRoute accessDenied = AppRoute(
    path: '/access-denied',
    name: 'access_denied',
  );
}
