import 'package:flutter_very_good_example/app/app.dart';
import 'package:flutter_very_good_example/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
