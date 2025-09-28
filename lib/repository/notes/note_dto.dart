import 'package:objectbox/objectbox.dart';

import 'package:serealappv2/repository/daily_logs/daily_log_dto.dart';

@Entity()
class NoteDto {
  NoteDto({
    required this.title,
    required this.content,
    required this.created,
    required this.edited,
  });

  @Id()
  int id = 0;

  final String title;
  final String content;

  @Property(type: PropertyType.date)
  final DateTime created;

  @Property(type: PropertyType.date)
  final DateTime edited;

  ToMany<DailyLogDto> logs = ToMany<DailyLogDto>();
}
