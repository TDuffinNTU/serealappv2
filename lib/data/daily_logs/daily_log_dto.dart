import 'package:objectbox/objectbox.dart';

import 'package:serealappv2/data/notes/note_dto.dart';
import 'package:serealappv2/data/tasks/task_dto.dart';

@Entity()
class DailyLog {
  DailyLog({required this.date});

  @Id()
  int id = 0;

  @Property(type: PropertyType.date)
  final DateTime date;

  final ToMany<Note> notes = ToMany();
  final ToMany<Task> tasks = ToMany();
}
