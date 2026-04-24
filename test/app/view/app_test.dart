import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/app/app.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';
import 'package:flutter_very_good_example/features/example/presentation/pages/example_page.dart';
import 'package:flutter_very_good_example/features/home/home.dart';

void main() {
  group('App', () {
    testWidgets('after splash, shows HomePage', (tester) async {
      await tester.pumpWidget(
        const App(config: AppConfig.forTesting),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('from home, opens example page', (tester) async {
      await tester.pumpWidget(
        const App(config: AppConfig.forTesting),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.byType(ExamplePage), findsOneWidget);
    });

    testWidgets(
      'dispose closes resources when widget is removed',
      (tester) async {
      await tester.pumpWidget(
        const App(config: AppConfig.forTesting),
      );
      await tester.pumpAndSettle();
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox.shrink(),
        ),
      );
    },
    );
  });
}
