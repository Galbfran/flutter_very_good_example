import 'package:flutter_very_good_example/core/config/app_env.dart';

/// Configuración por flavor (URLs, logging).
///
/// En ejecución normal, usá [AppConfig.fromFlavor] tras `dotenv.load` en
/// `bootstrap`. `String.fromEnvironment` con `API_BASE_URL` y
/// `ENABLE_NETWORK_LOGGING` sigue pudiendo sobreescribir en build/CI
/// (valores no vacíos / `true`/`false`).
class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.apiBaseUrl,
    required this.enableNetworkLogging,
  });

  /// Construye la config desde [AppEnv] (tras cargar el `.env` del flavor).
  factory AppConfig.fromFlavor(AppFlavor flavor) {
    return AppConfig(
      flavor: flavor,
      apiBaseUrl: _resolveApiBaseUrl(),
      enableNetworkLogging: _resolveNetworkLogging(),
    );
  }

  final AppFlavor flavor;
  final String apiBaseUrl;

  /// Si es true, el cliente HTTP registra requests/responses (dev/staging).
  final bool enableNetworkLogging;

  static String _resolveApiBaseUrl() {
    const fromDefine = String.fromEnvironment('API_BASE_URL');
    if (fromDefine.isNotEmpty) {
      return fromDefine;
    }
    return AppEnv.apiBaseUrl;
  }

  static bool _resolveNetworkLogging() {
    const fromDefine = String.fromEnvironment('ENABLE_NETWORK_LOGGING');
    if (fromDefine == 'true' || fromDefine == '1') {
      return true;
    }
    if (fromDefine == 'false' || fromDefine == '0') {
      return false;
    }
    return AppEnv.enableNetworkLogging;
  }

  /// Widget tests: sin cargar el paquete `flutter_dotenv` ni assets.
  static const AppConfig forTesting = AppConfig(
    flavor: AppFlavor.development,
    apiBaseUrl: 'https://api-test.local',
    enableNetworkLogging: false,
  );
}

enum AppFlavor {
  development,
  staging,
  production,
}
