import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/domain/counter_snapshot.dart';

void main() {
  group('CounterSnapshot', () {
    test('supports value equality', () {
      expect(
        const CounterSnapshot(current: 1, previous: 0),
        equals(const CounterSnapshot(current: 1, previous: 0)),
      );
      expect(
        const CounterSnapshot(current: 1, previous: 0),
        isNot(equals(const CounterSnapshot(current: 2, previous: 1))),
      );
    });
  });
}
