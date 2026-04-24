import 'package:flutter_very_good_example/features/counter/domain/counter_snapshot.dart';

/// Contrato de acceso al contador (API real o implementación simulada).
abstract class CounterRepository {
  Future<CounterSnapshot> increment(CounterSnapshot from);

  Future<CounterSnapshot> decrement(CounterSnapshot from);
}
