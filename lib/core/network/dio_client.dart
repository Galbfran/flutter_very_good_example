import 'package:dio/dio.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';
import 'package:flutter_very_good_example/core/network/interceptors/dio_logger_interceptor.dart';

/// Cliente HTTP compartido; baseUrl y timeouts según la config del flavor.
///
/// [extraInterceptors] se insertan primero (útil para mocks o auth).
Dio createDio(
  AppConfig config, {
  List<Interceptor> extraInterceptors = const [],
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    ),
  );

  extraInterceptors.forEach(dio.interceptors.add);

  if (config.enableNetworkLogging) {
    dio.interceptors.add(DioLoggerInterceptor());
  }

  return dio;
}
