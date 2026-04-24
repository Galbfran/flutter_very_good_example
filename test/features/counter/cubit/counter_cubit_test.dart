import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/counter.dart';

import '../support/counter_test_doubles.dart';

void main() {
  group('CounterCubit', () {
    test('initial state has zero snapshot and initial status', () {
      expect(
        CounterCubit(FakeCounterRepository()).state,
        const CounterCubitState(),
      );
    });

    blocTest<CounterCubit, CounterCubitState>(
      'emits loading then success when increment succeeds',
      build: () => CounterCubit(FakeCounterRepository()),
      act: (cubit) => cubit.increment(),
      expect: () => const [
        CounterCubitState(status: CounterCubitStatus.loading),
        CounterCubitState(
          status: CounterCubitStatus.success,
          snapshot: CounterSnapshot(current: 1, previous: 0),
        ),
      ],
    );

    blocTest<CounterCubit, CounterCubitState>(
      'emits loading then success when decrement succeeds',
      build: () => CounterCubit(FakeCounterRepository()),
      act: (cubit) => cubit.decrement(),
      expect: () => const [
        CounterCubitState(status: CounterCubitStatus.loading),
        CounterCubitState(
          status: CounterCubitStatus.success,
          snapshot: CounterSnapshot(current: -1, previous: 0),
        ),
      ],
    );

    blocTest<CounterCubit, CounterCubitState>(
      'emits loading then failure when increment throws',
      build: () => CounterCubit(FailingCounterRepository()),
      act: (cubit) => cubit.increment(),
      expect: () => const [
        CounterCubitState(status: CounterCubitStatus.loading),
        CounterCubitState(
          status: CounterCubitStatus.failure,
          errorMessage: 'Exception: simulated failure',
        ),
      ],
    );
  });
}
