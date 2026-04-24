import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/data/api_example_repository.dart';
import 'package:flutter_very_good_example/features/example/data/interceptors/example_mock_interceptor.dart';
import 'package:flutter_very_good_example/features/example/domain/example_snapshot.dart';

void main() {
  group('ApiExampleRepository', () {
    late Dio dio;
    late ApiExampleRepository repository;

    setUp(() {
      dio = Dio(
        BaseOptions(baseUrl: 'https://api-test.example.com'),
      )..interceptors.add(ExampleMockInterceptor(networkDelay: Duration.zero));
      repository = ApiExampleRepository(dio: dio);
    });

    tearDown(() => dio.close(force: true));

    test('increment maps response to snapshot', () async {
      const from = ExampleSnapshot(current: 2, previous: 1);
      final next = await repository.increment(from);
      expect(next.current, 3);
      expect(next.previous, 2);
    });

    test('decrement maps response to snapshot', () async {
      const from = ExampleSnapshot(current: 2, previous: 3);
      final next = await repository.decrement(from);
      expect(next.current, 1);
      expect(next.previous, 2);
    });

    test('throws when response body is null', () async {
      dio =
          Dio(
              BaseOptions(baseUrl: 'https://api-test.example.com'),
            )
            ..interceptors.add(
              InterceptorsWrapper(
                onRequest: (options, handler) {
                  handler.resolve(
                    Response<dynamic>(requestOptions: options),
                  );
                },
              ),
            );
      repository = ApiExampleRepository(dio: dio);

      await expectLater(
        repository.increment(
          const ExampleSnapshot(current: 0, previous: 0),
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            'Example API returned empty body',
          ),
        ),
      );
    });
  });
}
