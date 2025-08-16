import 'package:objectbox/objectbox.dart';
import 'package:serealappv2/domain/entities/log.dart';

@Entity()
class Note {
  Note({required this.content});

  @Id()
  int id = 0;

  final String content;

  ToMany<Log> logs = ToMany<Log>();
}
