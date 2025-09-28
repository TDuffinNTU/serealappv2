import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_log_model.freezed.dart';

@freezed
class DailyLog with _$DailyLog {
  DailyLog({
    required this.guid,
    required this.date,
    required this.notes,
    required this.tasks,
  });

  final String guid;
  final DateTime date;
  final List<Note> notes;
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
