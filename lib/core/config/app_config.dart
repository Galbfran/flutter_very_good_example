/// Configuración por flavor (URLs, logging). Sustituí los hosts por los reales.
class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.apiBaseUrl,
    required this.enableNetworkLogging,
  });

  final AppFlavor flavor;
  final String apiBaseUrl;

  /// Si es true, el cliente HTTP registra requests/responses (dev/staging).
  final bool enableNetworkLogging;

  static const development = AppConfig(
    flavor: AppFlavor.development,
    apiBaseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api-dev.example.com',
    ),
    enableNetworkLogging: true,
  );

  static const staging = AppConfig(
    flavor: AppFlavor.staging,
    apiBaseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api-staging.example.com',
    ),
    enableNetworkLogging: true,
  );

  static const production = AppConfig(
    flavor: AppFlavor.production,
    apiBaseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.example.com',
    ),
    enableNetworkLogging: false,
  );

  /// Para tests de widget; misma base que development.
  static const AppConfig forTesting = development;
}

enum AppFlavor {
  development,
  staging,
  production,
}
