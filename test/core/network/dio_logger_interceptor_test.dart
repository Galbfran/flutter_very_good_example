import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/core/network/interceptors/dio_logger_interceptor.dart';
import 'package:mocktail/mocktail.dart';

class _MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.cancel,
      ),
    );
  });

  group('DioLoggerInterceptor', () {
    test('onRequest calls next on handler', () {
      final interceptor = DioLoggerInterceptor();
      final options = RequestOptions(path: '/x');
      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);
      expect(handler.isCompleted, isTrue);
    });

    test('onResponse calls next on handler', () {
      final interceptor = DioLoggerInterceptor();
      final options = RequestOptions(path: '/x');
      final response = Response<dynamic>(requestOptions: options, data: 1);
      final handler = ResponseInterceptorHandler();
      interceptor.onResponse(response, handler);
      expect(handler.isCompleted, isTrue);
    });

    test('onError calls next on handler', () {
      final interceptor = DioLoggerInterceptor();
      final options = RequestOptions(path: '/x');
      final error = DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: 'e',
      );
      final handler = _MockErrorInterceptorHandler();
      interceptor.onError(error, handler);
      verify(() => handler.next(error)).called(1);
    });
  });
}
