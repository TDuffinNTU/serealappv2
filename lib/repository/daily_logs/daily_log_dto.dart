import 'package:objectbox/objectbox.dart';

import 'package:serealappv2/repository/notes/note_dto.dart';
import 'package:serealappv2/repository/tasks/task_dto.dart';

@Entity()
class DailyLogDto {
  DailyLogDto({
    required this.guid,
    required this.date,
    this.id = 0,
  });

  @Id()
  int id = 0;

  @Index()
  final String guid;

  @Property(type: PropertyType.date)
  final DateTime date;

  final ToMany<NoteDto> notes = ToMany();
  final ToMany<TaskDto> tasks = ToMany();
}
