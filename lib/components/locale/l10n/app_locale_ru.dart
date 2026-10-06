// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocaleRu extends AppLocale {
  AppLocaleRu([String locale = 'ru']) : super(locale);

  @override
  String get all => 'Все';

  @override
  String get typeApartment => 'Квартира';

  @override
  String get typeHouse => 'Дом';

  @override
  String get typeOffice => 'Офис';

  @override
  String get anyPrice => 'Любая цена';

  @override
  String priceUpTo(int price) {
    return 'До $price ₽ в сутки';
  }

  @override
  String get retry => 'Повторить';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String get perDay => '₽ / сутки';

  @override
  String get squareMeters => 'м²';

  @override
  String get district => 'Район';

  @override
  String get agent => 'Агент';

  @override
  String get notSpecified => 'Не указан';

  @override
  String get statusDraft => 'Черновик';

  @override
  String get statusModeration => 'На модерации';

  @override
  String get statusActive => 'Опубликовано';

  @override
  String get statusSuspended => 'Приостановлено';

  @override
  String get statusArchived => 'В архиве';

  @override
  String get liked => 'добавлено в избранное';

  @override
  String get disliked => 'удалено из избранного';

  @override
  String get arbEnding => 'Чтобы не забыть про отсутствие запятой :)';
}
