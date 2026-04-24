import 'package:flutter/widgets.dart';
import 'package:flutter_very_good_example/l10n/gen/app_localizations.dart';

export 'package:flutter_very_good_example/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
