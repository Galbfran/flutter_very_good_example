import 'package:dio/dio.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/data/models/{{name.snakeCase()}}_adjust_response.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/domain/{{name.snakeCase()}}_repository.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/domain/{{name.snakeCase()}}_snapshot.dart';

/// Cliente HTTP del contador; asume `POST /{{name.snakeCase()}}/adjust` con body
/// `{ current, previous, delta }` y respuesta `{ current, previous }`.
class Api{{name.pascalCase()}}Repository implements {{name.pascalCase()}}Repository {
  Api{{name.pascalCase()}}Repository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static const _path = '/{{name.snakeCase()}}/adjust';

  @override
  Future<{{name.pascalCase()}}Snapshot> increment({{name.pascalCase()}}Snapshot from) =>
      _adjust(from, delta: 1);

  @override
  Future<{{name.pascalCase()}}Snapshot> decrement({{name.pascalCase()}}Snapshot from) =>
      _adjust(from, delta: -1);

  Future<{{name.pascalCase()}}Snapshot> _adjust(
    {{name.pascalCase()}}Snapshot from, {
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
      throw StateError('{{name.pascalCase()}} API returned empty body');
    }

    final parsed = {{name.pascalCase()}}AdjustResponse.fromJson(data);
    return {{name.pascalCase()}}Snapshot(
      current: parsed.current,
      previous: parsed.previous,
    );
  }
}
