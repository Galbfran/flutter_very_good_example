import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/example.dart';

import '../support/example_test_doubles.dart';

void main() {
  group('ExampleCubit', () {
    test('initial state has zero snapshot and initial status', () {
      expect(
        ExampleCubit(FakeExampleRepository()).state,
        const ExampleCubitState(),
      );
    });

    blocTest<ExampleCubit, ExampleCubitState>(
      'emits loading then success when increment succeeds',
      build: () => ExampleCubit(FakeExampleRepository()),
      act: (cubit) => cubit.increment(),
      expect: () => const [
        ExampleCubitState(status: ExampleCubitStatus.loading),
        ExampleCubitState(
          status: ExampleCubitStatus.success,
          snapshot: ExampleSnapshot(current: 1, previous: 0),
        ),
      ],
    );

    blocTest<ExampleCubit, ExampleCubitState>(
      'emits loading then success when decrement succeeds',
      build: () => ExampleCubit(FakeExampleRepository()),
      act: (cubit) => cubit.decrement(),
      expect: () => const [
        ExampleCubitState(status: ExampleCubitStatus.loading),
        ExampleCubitState(
          status: ExampleCubitStatus.success,
          snapshot: ExampleSnapshot(current: -1, previous: 0),
        ),
      ],
    );

    blocTest<ExampleCubit, ExampleCubitState>(
      'emits loading then failure when increment throws',
      build: () => ExampleCubit(FailingExampleRepository()),
      act: (cubit) => cubit.increment(),
      expect: () => const [
        ExampleCubitState(status: ExampleCubitStatus.loading),
        ExampleCubitState(
          status: ExampleCubitStatus.failure,
          errorMessage: 'Exception: simulated failure',
        ),
      ],
    );

    blocTest<ExampleCubit, ExampleCubitState>(
      'emits loading then failure when decrement throws',
      build: () => ExampleCubit(FailingExampleRepository()),
      act: (cubit) => cubit.decrement(),
      expect: () => const [
        ExampleCubitState(status: ExampleCubitStatus.loading),
        ExampleCubitState(
          status: ExampleCubitStatus.failure,
          errorMessage: 'Exception: simulated failure',
        ),
      ],
    );
  });
}
