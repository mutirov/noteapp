enum OrderOption {
  createdAt,
  updatedAt;

  String get name {
    return switch (this) {
      OrderOption.createdAt => 'Created Date',
      OrderOption.updatedAt => 'Updated Date',
    };
  }
}
