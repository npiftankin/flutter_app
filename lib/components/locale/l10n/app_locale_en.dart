// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocaleEn extends AppLocale {
  AppLocaleEn([String locale = 'en']) : super(locale);

  @override
  String get all => 'All';

  @override
  String get typeApartment => 'Apartment';

  @override
  String get typeHouse => 'House';

  @override
  String get typeOffice => 'Office';

  @override
  String get anyPrice => 'Any price';

  @override
  String priceUpTo(int price) {
    return 'Up to $price ₽ per day';
  }

  @override
  String get retry => 'Retry';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get perDay => '₽ / day';

  @override
  String get squareMeters => 'm²';

  @override
  String get district => 'District';

  @override
  String get agent => 'Agent';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusModeration => 'Under moderation';

  @override
  String get statusActive => 'Published';

  @override
  String get statusSuspended => 'Suspended';

  @override
  String get statusArchived => 'Archived';

  @override
  String get liked => 'added to favorites';

  @override
  String get disliked => 'removed from favorites';

  @override
  String get arbEnding => 'Reminder: no trailing comma above :)';
}
