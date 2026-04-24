import 'dart:async' show unawaited;

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
import 'package:flutter_very_good_example/localization/localization.dart';

import '../../features/example/support/example_test_doubles.dart';

/// El splash usa un `CircularProgressIndicator` con animación continua.
/// `WidgetTester.pumpAndSettle` no vuelve hasta alcanzar el timeout largo.
Future<void> _pumpAfterSplash(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 800));
  await tester.pump();
}

/// Tras navegar o un tap, sin exigir “idle” con animación infinita.
Future<void> _pumpAfterRouteChange(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

Finder _primaryButtonOnPage(Type page) {
  return find.descendant(
    of: find.byType(page),
    matching: find.byType(FilledButton),
  );
}

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
        await _pumpAfterSplash(tester);

        router.go('${AppRoutes.error.path}?message=hola');
        await _pumpAfterRouteChange(tester);
        expect(find.byType(ErrorPage), findsOneWidget);
        await tester.tap(_primaryButtonOnPage(ErrorPage));
        await _pumpAfterRouteChange(tester);
        expect(router.state.matchedLocation, AppRoutes.home.path);

        router.go('/ruta-que-no-existe');
        await _pumpAfterRouteChange(tester);
        expect(find.byType(NotFoundPage), findsOneWidget);
        await tester.tap(_primaryButtonOnPage(NotFoundPage));
        await _pumpAfterRouteChange(tester);
        expect(router.state.matchedLocation, AppRoutes.home.path);

        router.go(AppRoutes.accessDenied.path);
        await _pumpAfterRouteChange(tester);
        expect(find.byType(AccessDeniedPage), findsOneWidget);
        await tester.tap(_primaryButtonOnPage(AccessDeniedPage));
        await _pumpAfterRouteChange(tester);
        expect(router.state.matchedLocation, AppRoutes.home.path);

        router.go(AppRoutes.example.path);
        await _pumpAfterRouteChange(tester);
        expect(find.byType(ExamplePage), findsOneWidget);
        expect(router.state.matchedLocation, AppRoutes.example.path);
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
      await _pumpAfterSplash(tester);
      expect(router.state.matchedLocation, AppRoutes.home.path);

      // [GoRouter.push] no completa el Future hasta el pop de la ruta: no
      // usar await o el test se bloquea antes del tap.
      unawaited(
        router.push<String?>('${AppRoutes.error.path}?message=%20%20%20'),
      );
      await _pumpAfterRouteChange(tester);
      expect(find.byType(ErrorPage), findsOneWidget);
      await tester.tap(_primaryButtonOnPage(ErrorPage));
      await _pumpAfterRouteChange(tester);
      expect(router.state.matchedLocation, AppRoutes.home.path);

      final msg = Uri.encodeComponent('  ok  ');
      unawaited(router.push<String?>('${AppRoutes.error.path}?message=$msg'));
      await _pumpAfterRouteChange(tester);
      expect(find.textContaining('ok'), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: find.byType(ErrorPage),
          matching: find.byType(OutlinedButton),
        ),
      );
      await _pumpAfterRouteChange(tester);
      expect(router.state.matchedLocation, AppRoutes.home.path);

      router.go(AppRoutes.error.path);
      await _pumpAfterRouteChange(tester);
      expect(find.byType(ErrorPage), findsOneWidget);
    });
  });
}
