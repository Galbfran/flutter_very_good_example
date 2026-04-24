import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/example.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';
import '../../support/example_mock_cubit.dart';

void main() {
  group('ExampleView', () {
    late MockExampleCubit exampleCubit;

    setUp(() {
      exampleCubit = MockExampleCubit();
    });

    testWidgets('renders current count', (tester) async {
      const state = ExampleCubitState(
        status: ExampleCubitStatus.success,
        snapshot: ExampleSnapshot(current: 42, previous: 41),
      );
      when(() => exampleCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider<ExampleCubit>.value(
          value: exampleCubit,
          child: const ExampleView(),
        ),
      );
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped', (
      tester,
    ) async {
      when(() => exampleCubit.state).thenReturn(const ExampleCubitState());
      when(() => exampleCubit.increment()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider<ExampleCubit>.value(
          value: exampleCubit,
          child: const ExampleView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verify(() => exampleCubit.increment()).called(1);
    });

    testWidgets('calls decrement when decrement button is tapped', (
      tester,
    ) async {
      when(() => exampleCubit.state).thenReturn(const ExampleCubitState());
      when(() => exampleCubit.decrement()).thenAnswer((_) async {});
      await tester.pumpApp(
        BlocProvider<ExampleCubit>.value(
          value: exampleCubit,
          child: const ExampleView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => exampleCubit.decrement()).called(1);
    });
  });
}
