import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';
import 'package:flutter_very_good_example/core/router/app_router.dart';
import 'package:flutter_very_good_example/core/router/app_routes.dart';
import 'package:flutter_very_good_example/core/router/pages/access_denied_page.dart';
import 'package:flutter_very_good_example/core/router/pages/error_page.dart';
import 'package:flutter_very_good_example/core/router/pages/not_found_page.dart';
import 'package:flutter_very_good_example/features/example/domain/example_repository.dart';
import 'package:flutter_very_good_example/features/example/presentation/pages/example_page.dart';
import 'package:flutter_very_good_example/features/home/presentation/pages/home_page.dart';
import 'package:flutter_very_good_example/localization/localization.dart';

import '../../features/example/support/example_test_doubles.dart';

void main() {
  group('createAppRouter', () {
    testWidgets(
      'navigates to error, 404, access denied, and example',
      (tester) async {
        final router = createAppRouter(AppConfig.forTesting);
        await tester.pumpWidget(
          RepositoryProvider<ExampleRepository>(
            create: (_) => FakeExampleRepository(),
            child: MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData(),
              routerConfig: router,
            ),
          ),
        );
        await tester.pumpAndSettle();

        router.go('${AppRoutes.error.path}?message=hola');
        await tester.pumpAndSettle();
        expect(find.byType(ErrorPage), findsOneWidget);
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);

        router.go('/ruta-que-no-existe');
        await tester.pumpAndSettle();
        expect(find.byType(NotFoundPage), findsOneWidget);
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);

        router.go(AppRoutes.accessDenied.path);
        await tester.pumpAndSettle();
        expect(find.byType(AccessDeniedPage), findsOneWidget);
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);

        router.go(AppRoutes.example.path);
        await tester.pumpAndSettle();
        expect(find.byType(ExamplePage), findsOneWidget);
      },
    );

    testWidgets('error page: default message, pop, and trim', (tester) async {
      final router = createAppRouter(AppConfig.forTesting);
      await tester.pumpWidget(
        RepositoryProvider<ExampleRepository>(
          create: (_) => FakeExampleRepository(),
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(),
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      await router.push('${AppRoutes.error.path}?message=%20%20%20');
      await tester.pumpAndSettle();
      expect(find.byType(ErrorPage), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      final msg = Uri.encodeComponent('  ok  ');
      await router.push('${AppRoutes.error.path}?message=$msg');
      await tester.pumpAndSettle();
      expect(find.textContaining('ok'), findsOneWidget);
      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      router.go(AppRoutes.error.path);
      await tester.pumpAndSettle();
      expect(find.byType(ErrorPage), findsOneWidget);
    });
  });
}
