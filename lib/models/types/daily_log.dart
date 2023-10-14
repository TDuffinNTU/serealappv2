import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';
import 'package:uuid/uuid.dart';

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
    required String id,
  }) = _DailyLog;

  factory DailyLog.fromJson(Map<String, dynamic> json) => _$DailyLogFromJson(json);

  factory DailyLog.defaults({DateTime? date}) => DailyLog(
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
        date: date != null ? date.dateOnly : DateTime.now().dateOnly,
        id: Uuid().v1(),
      );

  const DailyLog._();

  DailyLog updateMeal({required int index, required Meal newMeal}) => this.copyWith(
        meals: [
          for (int i = 0; i < this.meals.length; i++) i == index ? newMeal : this.meals[i],
        ],
      );

  DailyLog updateSnack({required int index, required Meal newSnack}) => this.copyWith(
        snacks: [
          for (int i = 0; i < this.snacks.length; i++) i == index ? newSnack : this.snacks[i],
        ],
      );

  DailyLog updateTodo({required int index, required Todo newTodo}) => this.copyWith(
        todos: [
          for (int i = 0; i < this.todos.length; i++) i == index ? newTodo : this.todos[i],
        ],
      );
}
