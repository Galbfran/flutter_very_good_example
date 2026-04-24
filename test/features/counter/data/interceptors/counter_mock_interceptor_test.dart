import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/data/interceptors/counter_mock_interceptor.dart';

void main() {
  group('CounterMockInterceptor', () {
    late Dio dio;

    setUp(() {
      dio = Dio(
        BaseOptions(baseUrl: 'https://api-test.example.com'),
      )..interceptors.add(CounterMockInterceptor(networkDelay: Duration.zero));
    });

    tearDown(() => dio.close(force: true));

    test('resolves POST /counter/adjust with computed JSON', () async {
      final response = await dio.post<Map<String, dynamic>>(
        '/counter/adjust',
        data: <String, dynamic>{'current': 4, 'previous': 3, 'delta': 1},
      );
      expect(response.statusCode, 200);
      expect(response.data, <String, dynamic>{'current': 5, 'previous': 4});
    });

    test('rejects when body is not a JSON object', () async {
      expect(
        () => dio.post<void>('/counter/adjust', data: 'invalid'),
        throwsA(isA<DioException>()),
      );
    });
  });
}
