import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';
import 'package:flutter_very_good_example/core/network/dio_client.dart';
import 'package:flutter_very_good_example/core/network/interceptors/dio_logger_interceptor.dart';

void main() {
  group('createDio', () {
    test('adds DioLoggerInterceptor when network logging is enabled', () {
      final dio = createDio(
        const AppConfig(
          flavor: AppFlavor.development,
          apiBaseUrl: 'https://api-test.example.com',
          enableNetworkLogging: true,
        ),
      );
      addTearDown(() => dio.close(force: true));
      final hasLogger = dio.interceptors.any(
        (i) => i is DioLoggerInterceptor,
      );
      expect(hasLogger, isTrue);
    });

    test('omits logger when network logging is disabled', () {
      final dio = createDio(
        const AppConfig(
          flavor: AppFlavor.production,
          apiBaseUrl: 'https://api-test.example.com',
          enableNetworkLogging: false,
        ),
      );
      addTearDown(() => dio.close(force: true));
      final hasLogger = dio.interceptors.any(
        (i) => i is DioLoggerInterceptor,
      );
      expect(hasLogger, isFalse);
    });
  });
}
