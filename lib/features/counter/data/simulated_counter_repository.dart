import 'package:flutter_very_good_example/features/counter/domain/counter_repository.dart';
import 'package:flutter_very_good_example/features/counter/domain/counter_snapshot.dart';

/// Simula latencia de red; misma interfaz que un cliente HTTP futuro.
class SimulatedCounterRepository implements CounterRepository {
  SimulatedCounterRepository({
    this.networkDelay = const Duration(milliseconds: 350),
  });

  final Duration networkDelay;

  @override
  Future<CounterSnapshot> increment(CounterSnapshot from) async {
    await Future<void>.delayed(networkDelay);
    final next = from.current + 1;
    return CounterSnapshot(current: next, previous: from.current);
  }

  @override
  Future<CounterSnapshot> decrement(CounterSnapshot from) async {
    await Future<void>.delayed(networkDelay);
    final next = from.current - 1;
    return CounterSnapshot(current: next, previous: from.current);
  }
}
