import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  Task({
    this.completed = false,
    required this.task,
  });

  @Id()
  int id = 0;

  final bool completed;
  final String task;
}
