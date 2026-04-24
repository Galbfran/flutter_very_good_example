import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_cubit.dart';
import 'package:flutter_very_good_example/features/counter/presentation/widgets/counter_view_listeners.dart';

import '../../support/counter_test_doubles.dart';

void main() {
  group('CounterViewListeners', () {
    testWidgets('shows SnackBar when cubit emits failure', (tester) async {
      final cubit = CounterCubit(FailingCounterRepository());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<CounterCubit>.value(
              value: cubit,
              child: const CounterViewListeners(
                child: SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );
      await cubit.increment();
      await tester.pump();
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('simulated failure'), findsOneWidget);
    });
  });
}
