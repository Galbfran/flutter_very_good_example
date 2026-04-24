import 'package:dio/dio.dart';
import 'package:flutter_very_good_example/features/example/data/models/example_adjust_response.dart';
import 'package:flutter_very_good_example/features/example/domain/example_repository.dart';
import 'package:flutter_very_good_example/features/example/domain/example_snapshot.dart';

/// Cliente HTTP del contador; asume `POST /example/adjust` con body
/// `{ current, previous, delta }` y respuesta `{ current, previous }`.
class ApiExampleRepository implements ExampleRepository {
  ApiExampleRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static const _path = '/example/adjust';

  @override
  Future<ExampleSnapshot> increment(ExampleSnapshot from) =>
      _adjust(from, delta: 1);

  @override
  Future<ExampleSnapshot> decrement(ExampleSnapshot from) =>
      _adjust(from, delta: -1);

  Future<ExampleSnapshot> _adjust(
    ExampleSnapshot from, {
    required int delta,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      _path,
      data: <String, dynamic>{
        'current': from.current,
        'previous': from.previous,
        'delta': delta,
      },
    );

    final data = response.data;
    if (data == null) {
      throw StateError('Example API returned empty body');
    }

    final parsed = ExampleAdjustResponse.fromJson(data);
    return ExampleSnapshot(
      current: parsed.current,
      previous: parsed.previous,
    );
  }
}
