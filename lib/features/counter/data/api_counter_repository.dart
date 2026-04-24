import 'package:dio/dio.dart';
import 'package:flutter_very_good_example/features/counter/data/models/counter_adjust_response.dart';
import 'package:flutter_very_good_example/features/counter/domain/counter_repository.dart';
import 'package:flutter_very_good_example/features/counter/domain/counter_snapshot.dart';

/// Cliente HTTP del contador; asume `POST /counter/adjust` con body
/// `{ current, previous, delta }` y respuesta `{ current, previous }`.
class ApiCounterRepository implements CounterRepository {
  ApiCounterRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static const _path = '/counter/adjust';

  @override
  Future<CounterSnapshot> increment(CounterSnapshot from) =>
      _adjust(from, delta: 1);

  @override
  Future<CounterSnapshot> decrement(CounterSnapshot from) =>
      _adjust(from, delta: -1);

  Future<CounterSnapshot> _adjust(
    CounterSnapshot from, {
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
      throw StateError('Counter API returned empty body');
    }

    final parsed = CounterAdjustResponse.fromJson(data);
    return CounterSnapshot(
      current: parsed.current,
      previous: parsed.previous,
    );
  }
}
