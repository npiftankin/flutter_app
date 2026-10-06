import 'package:flutter/widgets.dart';
import 'package:flutter_app/components/locale/l10n/app_locale.dart';

extension ContextX on BuildContext {
  AppLocale get locale => AppLocale.of(this)!;
}
