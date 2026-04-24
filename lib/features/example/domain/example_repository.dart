import 'package:flutter_very_good_example/features/example/domain/example_snapshot.dart';

/// Contrato de acceso al contador (API real o implementación simulada).
abstract class ExampleRepository {
  Future<ExampleSnapshot> increment(ExampleSnapshot from);

  Future<ExampleSnapshot> decrement(ExampleSnapshot from);
}
