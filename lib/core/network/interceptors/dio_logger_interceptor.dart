import 'dart:developer';

import 'package:dio/dio.dart';

/// Registra método, URL y errores en consola (si la config lo habilita).
final class DioLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('[Dio] → ${options.method} ${options.uri}', name: 'Dio');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final uri = response.requestOptions.uri;
    log('[Dio] ← ${response.statusCode} $uri', name: 'Dio');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final code = err.response?.statusCode;
    final uri = err.requestOptions.uri;
    log('[Dio] ✗ $code $uri ${err.message}', name: 'Dio');
    handler.next(err);
  }
}
