import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';
import 'package:flutter_very_good_example/core/config/load_env.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// Carga el `.env` del flavor, construye [AppConfig] y arranca la app.
///
/// [envAssetPath] es el posible **overlay** de flavor (p. ej.
/// `env/.env.development`); se fusiona con `env/.env.example` (siempre
/// requerido en `pubspec.yaml`).
Future<void> bootstrap(
  String envAssetPath,
  AppFlavor flavor,
  FutureOr<Widget> Function(AppConfig) builder,
) async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadEnvWithExampleBase(envAssetPath);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final config = AppConfig.fromFlavor(flavor);
  runApp(await builder(config));
}
