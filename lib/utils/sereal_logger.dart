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

mixin SerealLoggerMixin {
  void logInfo(String message) {
    log(
      message,
      name: '<I> ' + this.runtimeType.toString(),
      time: DateTime.now(),
    );
  }

  void error(
    String message, {
    required StackTrace stacktrace,
    required Object error,
  }) {
    log(
      message,
      name: '<E> ' + this.runtimeType.toString(),
      stackTrace: stacktrace,
      error: error,
      time: DateTime.now(),
    );
  }
}
