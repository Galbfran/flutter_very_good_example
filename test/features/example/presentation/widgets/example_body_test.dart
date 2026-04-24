import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/example.dart';
import 'package:flutter_very_good_example/features/example/presentation/widgets/example_body.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';
import '../../support/example_mock_cubit.dart';

void main() {
  group('ExampleBody', () {
    testWidgets('renders current and previous labels', (tester) async {
      final cubit = MockExampleCubit();
      const state = ExampleCubitState(
        status: ExampleCubitStatus.success,
        snapshot: ExampleSnapshot(current: 7, previous: 6),
      );
      when(() => cubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider<ExampleCubit>.value(
          value: cubit,
          child: const ExampleBody(),
        ),
      );
      expect(find.text('7'), findsOneWidget);
      expect(find.textContaining('6'), findsOneWidget);
    });

    testWidgets('shows LinearProgressIndicator when loading', (tester) async {
      final cubit = MockExampleCubit();
      when(() => cubit.state).thenReturn(
        const ExampleCubitState(status: ExampleCubitStatus.loading),
      );
      await tester.pumpApp(
        BlocProvider<ExampleCubit>.value(
          value: cubit,
          child: const ExampleBody(),
        ),
      );
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });
  });
}
