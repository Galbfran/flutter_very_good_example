import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';
import 'package:flutter_very_good_example/core/config/app_env.dart';

void main() {
  group('AppConfig.fromFlavor', () {
    test('toma API_BASE_URL y ENABLE_NETWORK_LOGGING del dotenv', () {
      dotenv.testLoad(
        fileInput: '''
API_BASE_URL=https://custom.example.com
API_KEY=
ENABLE_NETWORK_LOGGING=false
''',
      );
      addTearDown(dotenv.clean);
      final c = AppConfig.fromFlavor(AppFlavor.production);
      expect(c.apiBaseUrl, 'https://custom.example.com');
      expect(c.enableNetworkLogging, isFalse);
    });
  });

  group('AppEnv', () {
    test('apiKey null cuando API_KEY vacío o ausente', () {
      dotenv.testLoad(
        fileInput: '''
API_BASE_URL=x
API_KEY=
ENABLE_NETWORK_LOGGING=true
''',
      );
      addTearDown(dotenv.clean);
      expect(AppEnv.apiKey, isNull);
    });

    test('apiKey con valor', () {
      dotenv.testLoad(
        fileInput: '''
API_BASE_URL=x
API_KEY=ab12
ENABLE_NETWORK_LOGGING=true
''',
      );
      addTearDown(dotenv.clean);
      expect(AppEnv.apiKey, 'ab12');
    });

    test('apiBaseUrl usa fallback si falta API_BASE_URL', () {
      dotenv.testLoad(
        fileInput: 'ENABLE_NETWORK_LOGGING=true\n',
      );
      addTearDown(dotenv.clean);
      expect(
        AppEnv.apiBaseUrl,
        'https://api-dev.example.com',
      );
    });
  });
}
