import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const _kExamplePath = 'env/.env.example';

/// Carga `env/.env.example` (incluido en el repositorio) y, **si** existe en
/// el `AssetBundle` el archivo de flavor (`flavorEnvPath`), aplica su
/// contenido **encima** de la plantilla (mismas claves: gana el flavor).
///
/// Así en git solo hace falta el archivo `env/.env.example`; en local/CI se pueden copiar
/// `cp env/.env.example env/.env.development` (u otros) sin commitear.
Future<void> loadEnvWithExampleBase(String flavorEnvPath) async {
  final example = await rootBundle.loadString(_kExamplePath);
  var head = '';
  try {
    final overlay = await rootBundle.loadString(flavorEnvPath);
    if (overlay.isNotEmpty) {
      head = overlay.endsWith('\n') ? overlay : '$overlay\n';
    }
  } on Object {
    // Sin asset de flavor (no copiaste .example) u otro error; solo plantilla
  }
  dotenv.testLoad(fileInput: head + example);
}
