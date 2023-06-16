import 'meal.dart';
import 'note.dart';
import 'todo.dart';

class DailyLog {
  const DailyLog({
    required this.meals,
    required this.snacks,
    required this.todos,
    required this.note,
    required this.date,
  });

  static DailyLog create(DateTime? date) => DailyLog(
        meals: [
          Meal.create('Meal 1'),
          Meal.create('Meal 2'),
          Meal.create('Meal 3'),
        ],
        snacks: [
          Meal.create('Snack 1'),
          Meal.create('Snack 2'),
        ],
        todos: [
          Todo.create('New Todo'),
        ],
        note: Note(
          content: 'Empty note',
        ),
        date: date ?? DateTime.now(),
      );

  final List<Meal> meals;
  final List<Meal> snacks;
  final List<Todo> todos;
  final Note note;
  final DateTime date;
}
