import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/data/api_counter_repository.dart';
import 'package:flutter_very_good_example/features/counter/data/interceptors/counter_mock_interceptor.dart';
import 'package:flutter_very_good_example/features/counter/domain/counter_snapshot.dart';

void main() {
  group('ApiCounterRepository', () {
    late Dio dio;
    late ApiCounterRepository repository;

    setUp(() {
      dio = Dio(
        BaseOptions(baseUrl: 'https://api-test.example.com'),
      )..interceptors.add(CounterMockInterceptor(networkDelay: Duration.zero));
      repository = ApiCounterRepository(dio: dio);
    });

    tearDown(() => dio.close(force: true));

    test('increment maps response to snapshot', () async {
      const from = CounterSnapshot(current: 2, previous: 1);
      final next = await repository.increment(from);
      expect(next.current, 3);
      expect(next.previous, 2);
    });

    test('decrement maps response to snapshot', () async {
      const from = CounterSnapshot(current: 2, previous: 3);
      final next = await repository.decrement(from);
      expect(next.current, 1);
      expect(next.previous, 2);
    });
  });
}
