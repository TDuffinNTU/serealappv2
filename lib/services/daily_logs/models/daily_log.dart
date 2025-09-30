import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_log.freezed.dart';

@freezed
final class DailyLog with _$DailyLog {
  DailyLog({
    required this.guid,
    required this.date,
    required this.notes,
    required this.tasks,
  });

  @override
  final String guid;

  @override
  final DateTime date;

  @override
  final List<Note> notes;

  @override
  final List<Task> tasks;
}

class Note {
  Note({required this.guid});

  final String guid;
}

class Task {
  Task({required this.guid});

  final String guid;
}
