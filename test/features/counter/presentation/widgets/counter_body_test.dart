import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/counter.dart';
import 'package:flutter_very_good_example/features/counter/presentation/widgets/counter_body.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';
import '../../support/counter_mock_cubit.dart';

void main() {
  group('CounterBody', () {
    testWidgets('renders current and previous labels', (tester) async {
      final cubit = MockCounterCubit();
      const state = CounterCubitState(
        status: CounterCubitStatus.success,
        snapshot: CounterSnapshot(current: 7, previous: 6),
      );
      when(() => cubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider<CounterCubit>.value(
          value: cubit,
          child: const CounterBody(),
        ),
      );
      expect(find.text('7'), findsOneWidget);
      expect(find.textContaining('6'), findsOneWidget);
    });

    testWidgets('shows LinearProgressIndicator when loading', (tester) async {
      final cubit = MockCounterCubit();
      when(() => cubit.state).thenReturn(
        const CounterCubitState(status: CounterCubitStatus.loading),
      );
      await tester.pumpApp(
        BlocProvider<CounterCubit>.value(
          value: cubit,
          child: const CounterBody(),
        ),
      );
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });
  });
}
