extension DateTimeExtensions on DateTime {
  DateTime get dateOnly => copyWith(
        hour: 0,
        second: 0,
        minute: 0,
        millisecond: 0,
        microsecond: 0,
      );

  String get databaseType => dateOnly.toIso8601String();

  static DateTime get today => DateTime.now();

  static DateTime get tomorrow {
    return DateTime.now().dateOnly.add(const Duration(days: 1));
  }

  static DateTime get yesterday {
    return DateTime.now().dateOnly.subtract(const Duration(days: 1));
  }
}

DateTime today = DateTime.now();

DateTime tomorrow = DateTime.now().dateOnly.add(const Duration(days: 1));

DateTime yesterday = DateTime.now().dateOnly.subtract(const Duration(days: 1));
