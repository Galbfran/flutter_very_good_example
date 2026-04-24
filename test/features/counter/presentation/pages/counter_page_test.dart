import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/counter/counter.dart';
import 'package:flutter_very_good_example/features/counter/data/simulated_counter_repository.dart';

import '../../../../helpers/helpers.dart';

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
}
