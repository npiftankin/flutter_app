import 'package:flutter_app/domain/models/property_status.dart';

// Подписи совпадают с веб-клиентом (PROPERTY_STATUS_LABELS в React)
extension PropertyStatusLabel on PropertyStatus {
  String get label => switch (this) {
    PropertyStatus.draft => 'Черновик',
    PropertyStatus.moderation => 'На модерации',
    PropertyStatus.active => 'Опубликовано',
    PropertyStatus.suspended => 'Приостановлено',
    PropertyStatus.archived => 'В архиве',
  };
}
