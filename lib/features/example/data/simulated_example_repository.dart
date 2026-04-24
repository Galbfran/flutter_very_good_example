import 'package:flutter_very_good_example/features/example/domain/example_repository.dart';
import 'package:flutter_very_good_example/features/example/domain/example_snapshot.dart';

/// Simula latencia de red; misma interfaz que un cliente HTTP futuro.
class SimulatedExampleRepository implements ExampleRepository {
  SimulatedExampleRepository({
    this.networkDelay = const Duration(milliseconds: 350),
  });

  final Duration networkDelay;

  @override
  Future<ExampleSnapshot> increment(ExampleSnapshot from) async {
    await Future<void>.delayed(networkDelay);
    final next = from.current + 1;
    return ExampleSnapshot(current: next, previous: from.current);
  }

  @override
  Future<ExampleSnapshot> decrement(ExampleSnapshot from) async {
    await Future<void>.delayed(networkDelay);
    final next = from.current - 1;
    return ExampleSnapshot(current: next, previous: from.current);
  }
}
