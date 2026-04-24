// Mocktail + métodos async: lambdas explícitas en when/verify.
// ignore_for_file: unnecessary_lambdas

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/example.dart';
import 'package:flutter_very_good_example/features/example/presentation/widgets/example_floating_actions.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';
import '../../support/example_mock_cubit.dart';

void main() {
  group('ExampleFloatingActions', () {
    testWidgets('calls increment when not loading', (tester) async {
      final cubit = MockExampleCubit();
      when(() => cubit.state).thenReturn(const ExampleCubitState());
      when(() => cubit.increment()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider<ExampleCubit>.value(
          value: cubit,
          child: const ExampleFloatingActions(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verify(() => cubit.increment()).called(1);
    });

    testWidgets('calls decrement when not loading', (tester) async {
      final cubit = MockExampleCubit();
      when(() => cubit.state).thenReturn(const ExampleCubitState());
      when(() => cubit.decrement()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider<ExampleCubit>.value(
          value: cubit,
          child: const ExampleFloatingActions(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => cubit.decrement()).called(1);
    });

    testWidgets('does not call increment when loading', (tester) async {
      final cubit = MockExampleCubit();
      when(() => cubit.state).thenReturn(
        const ExampleCubitState(status: ExampleCubitStatus.loading),
      );
      await tester.pumpApp(
        BlocProvider<ExampleCubit>.value(
          value: cubit,
          child: const ExampleFloatingActions(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verifyNever(() => cubit.increment());
    });
  });
}
