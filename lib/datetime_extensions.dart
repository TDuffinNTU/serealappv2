extension DateTimeExtensions on DateTime {
  DateTime get dateOnly => this.copyWith(
        hour: 0,
        second: 0,
        minute: 0,
        millisecond: 0,
        microsecond: 0,
      );

  String get databaseType => this.dateOnly.toIso8601String();
}
