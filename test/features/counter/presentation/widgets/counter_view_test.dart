import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/counter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';
import '../../support/counter_mock_cubit.dart';

void main() {
  group('CounterView', () {
    late MockCounterCubit counterCubit;

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
        BlocProvider<CounterCubit>.value(
          value: counterCubit,
          child: const CounterView(),
        ),
      );
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped', (
      tester,
    ) async {
      when(() => counterCubit.state).thenReturn(const CounterCubitState());
      when(() => counterCubit.increment()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider<CounterCubit>.value(
          value: counterCubit,
          child: const CounterView(),
        ),
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
        BlocProvider<CounterCubit>.value(
          value: counterCubit,
          child: const CounterView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => counterCubit.decrement()).called(1);
    });
  });
}
