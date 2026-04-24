import 'package:flutter_very_good_example/features/example/example.dart';

/// Repositorio en memoria para tests de cubit (sin red).
class FakeExampleRepository implements ExampleRepository {
  @override
  Future<ExampleSnapshot> increment(ExampleSnapshot from) async {
    return ExampleSnapshot(current: from.current + 1, previous: from.current);
  }

  @override
  Future<ExampleSnapshot> decrement(ExampleSnapshot from) async {
    return ExampleSnapshot(current: from.current - 1, previous: from.current);
  }
}

/// Lanza en cada operación (p. ej. errores de red simulados).
class FailingExampleRepository implements ExampleRepository {
  @override
  Future<ExampleSnapshot> increment(ExampleSnapshot from) async {
    throw Exception('simulated failure');
  }

  @override
  Future<ExampleSnapshot> decrement(ExampleSnapshot from) async {
    throw Exception('simulated failure');
  }
}
