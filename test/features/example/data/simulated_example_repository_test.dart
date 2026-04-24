import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/data/simulated_example_repository.dart';
import 'package:flutter_very_good_example/features/example/domain/example_snapshot.dart';

void main() {
  group('SimulatedExampleRepository', () {
    test('increment returns next values after delay of zero', () async {
      const from = ExampleSnapshot(current: 2, previous: 0);
      final repository = SimulatedExampleRepository(
        networkDelay: Duration.zero,
      );
      final next = await repository.increment(from);
      expect(next.current, 3);
      expect(next.previous, 2);
    });

    test('decrement returns next values after delay of zero', () async {
      const from = ExampleSnapshot(current: 5, previous: 4);
      final repository = SimulatedExampleRepository(
        networkDelay: Duration.zero,
      );
      final next = await repository.decrement(from);
      expect(next.current, 4);
      expect(next.previous, 5);
    });
  });
}
