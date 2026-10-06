enum PropertyStatus {
  draft,
  moderation,
  active,
  suspended,
  archived;

  static PropertyStatus? fromServer(String? value) => switch (value) {
        'DRAFT' => PropertyStatus.draft,
        'MODERATION' => PropertyStatus.moderation,
        'ACTIVE' => PropertyStatus.active,
        'SUSPENDED' => PropertyStatus.suspended,
        'ARCHIVED' => PropertyStatus.archived,
        _ => null,
      };
}
