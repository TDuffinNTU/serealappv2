import 'dart:developer';

mixin SerealLoggerMixin {
  void logInfo(String message) {
    log(
      message,
      name: '<I> $runtimeType',
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
      name: '<E> $runtimeType',
      stackTrace: stacktrace,
      error: error,
      time: DateTime.now(),
    );
  }
}
