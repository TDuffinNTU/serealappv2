import 'dart:developer';

class SerealLogger {
  static void info({
    required String message,
    required String name,
  }) {
    log(
      message,
      name: name,
      time: DateTime.now(),
    );
  }

  static void error({
    required String message,
    required String name,
    required StackTrace stacktrace,
    required Object error,
  }) {
    log(
      message,
      name: name,
      stackTrace: stacktrace,
      error: error,
      time: DateTime.now(),
    );
  }
}
