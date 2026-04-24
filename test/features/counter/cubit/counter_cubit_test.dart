import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_very_good_example/features/counter/counter.dart';

class _FakeCounterRepository implements CounterRepository {
  @override
  Future<CounterSnapshot> increment(CounterSnapshot from) async {
    return CounterSnapshot(current: from.current + 1, previous: from.current);
  }

  @override
  Future<CounterSnapshot> decrement(CounterSnapshot from) async {
    return CounterSnapshot(current: from.current - 1, previous: from.current);
  }
}

class _FailingCounterRepository implements CounterRepository {
  @override
  Future<CounterSnapshot> increment(CounterSnapshot from) async {
    throw Exception('simulated failure');
  }

  @override
  Future<CounterSnapshot> decrement(CounterSnapshot from) async {
    throw Exception('simulated failure');
  }
}

void main() {
  group('CounterCubit', () {
    test('initial state has zero snapshot and initial status', () {
      expect(
        CounterCubit(_FakeCounterRepository()).state,
        const CounterCubitState(),
      );
    });

    blocTest<CounterCubit, CounterCubitState>(
      'emits loading then success when increment succeeds',
      build: () => CounterCubit(_FakeCounterRepository()),
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
      build: () => CounterCubit(_FakeCounterRepository()),
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
      build: () => CounterCubit(_FailingCounterRepository()),
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
