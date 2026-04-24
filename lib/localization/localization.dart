import 'package:flutter/widgets.dart';
import 'package:flutter_very_good_example/localization/gen/app_localizations.dart';

export 'package:flutter_very_good_example/localization/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this);
}
