import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/counter.dart';
import 'package:flutter_very_good_example/features/counter/data/simulated_counter_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class MockCounterCubit extends MockCubit<CounterCubitState>
    implements CounterCubit {}

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(
        RepositoryProvider<CounterRepository>(
          create: (_) =>
              SimulatedCounterRepository(networkDelay: Duration.zero),
          child: const CounterPage(),
        ),
      );
      expect(find.byType(CounterView), findsOneWidget);
    });
  });

  group('CounterView', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = MockCounterCubit();
    });

    testWidgets('renders current count', (tester) async {
      const state = CounterCubitState(
        status: CounterCubitStatus.success,
        snapshot: CounterSnapshot(current: 42, previous: 41),
      );
      when(() => counterCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(value: counterCubit, child: const CounterView()),
      );
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped', (
      tester,
    ) async {
      when(() => counterCubit.state).thenReturn(const CounterCubitState());
      when(() => counterCubit.increment()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider.value(value: counterCubit, child: const CounterView()),
      );
      await tester.tap(find.byIcon(Icons.add));
      verify(() => counterCubit.increment()).called(1);
    });

    testWidgets('calls decrement when decrement button is tapped', (
      tester,
    ) async {
      when(() => counterCubit.state).thenReturn(const CounterCubitState());
      when(() => counterCubit.decrement()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider.value(value: counterCubit, child: const CounterView()),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => counterCubit.decrement()).called(1);
    });
  });
}
