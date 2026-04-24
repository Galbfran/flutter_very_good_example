import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/domain/example_snapshot.dart';

void main() {
  group('ExampleSnapshot', () {
    test('supports value equality', () {
      expect(
        const ExampleSnapshot(current: 1, previous: 0),
        equals(const ExampleSnapshot(current: 1, previous: 0)),
      );
      expect(
        const ExampleSnapshot(current: 1, previous: 0),
        isNot(equals(const ExampleSnapshot(current: 2, previous: 1))),
      );
    });
  });
}
