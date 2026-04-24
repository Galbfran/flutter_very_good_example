import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/app/theme/app_theme.dart';
import 'package:flutter_very_good_example/core/bloc/app_global_bloc_providers.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';
import 'package:flutter_very_good_example/core/network/dio_client.dart';
import 'package:flutter_very_good_example/core/router/app_router.dart';
import 'package:flutter_very_good_example/features/example/data/api_example_repository.dart';
import 'package:flutter_very_good_example/features/example/data/interceptors/example_mock_interceptor.dart';
import 'package:flutter_very_good_example/features/example/domain/example_repository.dart';
import 'package:flutter_very_good_example/localization/localization.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  // [AppConfig] se construye en runtime desde el .env; no aplica un App const.

  const App({required this.config, super.key});

  final AppConfig config;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final Dio _dio = createDio(
    widget.config,
    extraInterceptors: [ExampleMockInterceptor()],
  );

  late final GoRouter _router = createAppRouter(widget.config);

  @override
  void dispose() {
    _dio.close(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ExampleRepository>(
      create: (_) => ApiExampleRepository(dio: _dio),
      child: AppGlobalBlocProviders(
        child: MaterialApp.router(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _router,
        ),
      ),
    );
  }
}
