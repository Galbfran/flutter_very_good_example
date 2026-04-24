import 'package:flutter_very_good_example/app/app.dart';
import 'package:flutter_very_good_example/bootstrap.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';

Future<void> main() {
  return bootstrap(
    'env/.env.production',
    AppFlavor.production,
    (config) => App(config: config),
  );
}
