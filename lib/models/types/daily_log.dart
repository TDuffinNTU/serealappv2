import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serealappv2/datetime_extensions.dart';

import 'todo.dart';
import 'meal.dart';
import 'note.dart';

part 'daily_log.freezed.dart';
part 'daily_log.g.dart';

@freezed
class DailyLog with _$DailyLog {
  const factory DailyLog({
    required List<Meal> meals,
    required List<Meal> snacks,
    required List<Todo> todos,
    required Note note,
    required DateTime date,
  }) = _DailyLog;

  factory DailyLog.fromJson(Map<String, dynamic> json) =>
      _$DailyLogFromJson(json);

  factory DailyLog.defaults(DateTime? date) => DailyLog(
        meals: [
          Meal.defaults('Meal 1'),
          Meal.defaults('Meal 2'),
          Meal.defaults('Meal 3'),
        ],
        snacks: [
          Meal.defaults('Snack 1'),
          Meal.defaults('Snack 2'),
        ],
        todos: [
          Todo.defaults('New Todo'),
        ],
        note: const Note(
          content: 'Empty note',
        ),
        date: date ?? DateTime.now().dateOnly(),
      );
}
