import 'package:flutter/material.dart';
import 'package:flutter_very_good_example/app/theme/app_theme.dart';
import 'package:flutter_very_good_example/core/bloc/app_global_bloc_providers.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';
import 'package:flutter_very_good_example/core/router/app_router.dart';
import 'package:flutter_very_good_example/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({required this.config, super.key});

  final AppConfig config;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router = createAppRouter(widget.config);

  @override
  Widget build(BuildContext context) {
    return AppGlobalBlocProviders(
      child: MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _router,
      ),
    );
  }
}
