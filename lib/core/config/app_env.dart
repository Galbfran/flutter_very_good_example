import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Valores leídos del `.env` cargado en `bootstrap` con `dotenv.load`.
///
/// No uses estos getters antes de `dotenv.load` (p. ej. en inicializadores
/// de top-level o const).
enum AppEnv {
  // La enumeración requiere al menos un valor; no se usa (solo statics abajo).
  // ignore: unused_field
  _
  ;

  static String get apiBaseUrl => dotenv.get(
    'API_BASE_URL',
    fallback: 'https://api-dev.example.com',
  );

  /// Clave opcional (vacío en el .env de ejemplo). Las claves sensibles no
  /// dejan de viajar con el binario: preferí backend o defines en CI.
  static String? get apiKey {
    final v = dotenv.maybeGet('API_KEY');
    if (v == null || v.isEmpty) return null;
    return v;
  }

  static bool get enableNetworkLogging => dotenv.getBool(
    'ENABLE_NETWORK_LOGGING',
    fallback: true,
  );
}
