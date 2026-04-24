import 'package:flutter_very_good_example/features/counter/counter.dart';

/// Repositorio en memoria para tests de cubit (sin red).
class FakeCounterRepository implements CounterRepository {
  @override
  Future<CounterSnapshot> increment(CounterSnapshot from) async {
    return CounterSnapshot(current: from.current + 1, previous: from.current);
  }

  @override
  Future<CounterSnapshot> decrement(CounterSnapshot from) async {
    return CounterSnapshot(current: from.current - 1, previous: from.current);
  }
}

/// Lanza en cada operación (p. ej. errores de red simulados).
class FailingCounterRepository implements CounterRepository {
  @override
  Future<CounterSnapshot> increment(CounterSnapshot from) async {
    throw Exception('simulated failure');
  }

  @override
  Future<CounterSnapshot> decrement(CounterSnapshot from) async {
    throw Exception('simulated failure');
  }
}
