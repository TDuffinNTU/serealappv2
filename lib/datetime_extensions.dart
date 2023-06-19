extension DateTimeExtensions on DateTime {
  DateTime get dateOnly => this.copyWith(
        hour: 0,
        second: 0,
        minute: 0,
        millisecond: 0,
        microsecond: 0,
      );

  String get databaseType => this.dateOnly.toIso8601String();

  static DateTime tomorrow() => DateTime.now().dateOnly.add(Duration(days: 1));

  static DateTime yesterday() =>
      DateTime.now().dateOnly.subtract(Duration(days: 1));
}
