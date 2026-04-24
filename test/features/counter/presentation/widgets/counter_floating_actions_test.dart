// Mocktail + métodos async: lambdas explícitas en when/verify.
// ignore_for_file: unnecessary_lambdas

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/counter.dart';
import 'package:flutter_very_good_example/features/counter/presentation/widgets/counter_floating_actions.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';
import '../../support/counter_mock_cubit.dart';

void main() {
  group('CounterFloatingActions', () {
    testWidgets('calls increment when not loading', (tester) async {
      final cubit = MockCounterCubit();
      when(() => cubit.state).thenReturn(const CounterCubitState());
      when(() => cubit.increment()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider<CounterCubit>.value(
          value: cubit,
          child: const CounterFloatingActions(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verify(() => cubit.increment()).called(1);
    });

    testWidgets('calls decrement when not loading', (tester) async {
      final cubit = MockCounterCubit();
      when(() => cubit.state).thenReturn(const CounterCubitState());
      when(() => cubit.decrement()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider<CounterCubit>.value(
          value: cubit,
          child: const CounterFloatingActions(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => cubit.decrement()).called(1);
    });

    testWidgets('does not call increment when loading', (tester) async {
      final cubit = MockCounterCubit();
      when(() => cubit.state).thenReturn(
        const CounterCubitState(status: CounterCubitStatus.loading),
      );
      await tester.pumpApp(
        BlocProvider<CounterCubit>.value(
          value: cubit,
          child: const CounterFloatingActions(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verifyNever(() => cubit.increment());
    });
  });
}
