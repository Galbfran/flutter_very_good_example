import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/features/example/data/simulated_example_repository.dart';
import 'package:flutter_very_good_example/features/example/example.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('ExamplePage', () {
    testWidgets('renders ExampleView', (tester) async {
      await tester.pumpApp(
        RepositoryProvider<ExampleRepository>(
          create: (_) =>
              SimulatedExampleRepository(networkDelay: Duration.zero),
          child: const ExamplePage(),
        ),
      );
      expect(find.byType(ExampleView), findsOneWidget);
    });
  });
}
