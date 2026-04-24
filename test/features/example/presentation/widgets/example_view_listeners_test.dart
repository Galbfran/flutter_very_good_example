import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_cubit.dart';
import 'package:flutter_very_good_example/features/example/presentation/widgets/example_view_listeners.dart';

import '../../support/example_test_doubles.dart';

void main() {
  group('ExampleViewListeners', () {
    testWidgets('shows SnackBar when cubit emits failure', (tester) async {
      final cubit = ExampleCubit(FailingExampleRepository());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ExampleCubit>.value(
              value: cubit,
              child: const ExampleViewListeners(
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
