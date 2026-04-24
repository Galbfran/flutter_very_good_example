import 'package:flutter_very_good_example/app/app.dart';
import 'package:flutter_very_good_example/bootstrap.dart';
import 'package:flutter_very_good_example/core/config/app_config.dart';

Future<void> main() async {
  await bootstrap(() => const App(config: AppConfig.staging));
}
