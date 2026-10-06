import 'package:flutter/widgets.dart';
import 'package:flutter_app/components/extensions/context_x.dart';
import 'package:flutter_app/domain/models/property_status.dart';

extension PropertyStatusLabel on PropertyStatus {
  String label(BuildContext context) => switch (this) {
    PropertyStatus.draft => context.locale.statusDraft,
    PropertyStatus.moderation => context.locale.statusModeration,
    PropertyStatus.active => context.locale.statusActive,
    PropertyStatus.suspended => context.locale.statusSuspended,
    PropertyStatus.archived => context.locale.statusArchived,
  };
}

String typeLabel(BuildContext context, String? type) => switch (type) {
  'Квартира' => context.locale.typeApartment,
  'Дом' => context.locale.typeHouse,
  'Офис' => context.locale.typeOffice,
  _ => type ?? '',
};
