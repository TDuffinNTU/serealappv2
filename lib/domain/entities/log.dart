import 'package:objectbox/objectbox.dart';
import 'package:serealappv2/domain/entities/note.dart';
import 'package:serealappv2/domain/entities/task.dart';

@Entity()
class Log {
  Log({required this.date});

  @Id()
  int id = 0;

  final DateTime date;

  ToMany<Note> notes = ToMany();
  ToMany<Task> tasks = ToMany();
}
