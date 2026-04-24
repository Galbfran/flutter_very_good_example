import 'package:dio/dio.dart';

/// Simula `POST …/example/adjust` sin backend real.
///
/// Quitá este interceptor cuando el servidor implemente el mismo contrato.
class ExampleMockInterceptor extends Interceptor {
  ExampleMockInterceptor({
    this.networkDelay = const Duration(milliseconds: 300),
  });

  static const pathSegment = '/example/adjust';

  final Duration networkDelay;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.uri.path;
    if (!path.endsWith(pathSegment) || options.method != 'POST') {
      return handler.next(options);
    }

    await Future<void>.delayed(networkDelay);

    final body = options.data;
    if (body is! Map) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Expected JSON object body',
          type: DioExceptionType.badResponse,
        ),
      );
    }

    final map = Map<String, dynamic>.from(body);
    final current = (map['current'] as num?)?.toInt() ?? 0;
    final delta = (map['delta'] as num?)?.toInt() ?? 0;
    final next = current + delta;

    return handler.resolve(
      Response<Map<String, dynamic>>(
        requestOptions: options,
        statusCode: 200,
        data: <String, dynamic>{
          'current': next,
          'previous': current,
        },
      ),
    );
  }
}
