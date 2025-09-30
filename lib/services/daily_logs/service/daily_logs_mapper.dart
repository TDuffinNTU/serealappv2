import 'package:serealappv2/repository/daily_logs/daily_log_dto.dart';
import 'package:serealappv2/repository/notes/note_dto.dart';
import 'package:serealappv2/repository/tasks/task_dto.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log.dart';

class DailyLogsMapper {
  static DailyLog toModel(DailyLogDto value) {
    return DailyLog(
      guid: value.guid,
      date: value.date,
      notes: value.notes.map((n) => Note(guid: '')).toList(),
      tasks: value.tasks.map((t) => Task(guid: '')).toList(),
    );
  }

  static DailyLogDto toDto(DailyLog value) {
    return DailyLogDto(
      guid: value.guid,
      date: value.date,
    )
      ..notes.addAll(
        value.notes.map(
          (n) => NoteDto(
            title: 'title',
            content: 'content',
            created: value.date,
            edited: DateTime.now(),
          ),
        ),
      )
      ..tasks.addAll(
        value.tasks.map(
          (e) => TaskDto(task: 'task'),
        ),
      );
  }
}

/// Maps a list of [IN] objects to a list of [OUT] objects.
List<OUT> listMapper<IN, OUT>(
  List<IN> input,
  OUT Function(IN value) mapper,
) {
  return input.map(mapper).toList();
}
