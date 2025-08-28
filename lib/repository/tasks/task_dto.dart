import 'package:objectbox/objectbox.dart';
import 'package:serealappv2/repository/daily_logs/daily_log_dto.dart';

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

  final ToOne<DailyLog> logs = ToOne();
}
