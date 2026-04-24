import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/example.dart';

void main() {
  group('ExampleCubitState', () {
    test('copyWith can clear error and set loading status', () {
      const withError = ExampleCubitState(
        status: ExampleCubitStatus.failure,
        errorMessage: 'e',
      );
      final cleared = withError.copyWith(
        clearError: true,
        status: ExampleCubitStatus.loading,
      );
      expect(cleared.errorMessage, isNull);
      expect(cleared.status, ExampleCubitStatus.loading);
    });

    test('copyWith can replace errorMessage when not clearing', () {
      const state = ExampleCubitState();
      final next = state.copyWith(
        errorMessage: 'nuevo',
        status: ExampleCubitStatus.failure,
      );
      expect(next.errorMessage, 'nuevo');
      expect(next.status, ExampleCubitStatus.failure);
    });

    test('copyWith keeps previous snapshot when status is omitted', () {
      const s = ExampleCubitState(
        status: ExampleCubitStatus.success,
        snapshot: ExampleSnapshot(current: 3, previous: 1),
      );
      const newSnap = ExampleSnapshot(current: 4, previous: 3);
      final next = s.copyWith(snapshot: newSnap);
      expect(next.status, ExampleCubitStatus.success);
      expect(next.snapshot, newSnap);
    });
  });
}
