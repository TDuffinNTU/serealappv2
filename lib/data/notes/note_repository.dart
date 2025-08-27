import 'package:serealappv2/data/common/repository.dart';
import 'package:serealappv2/data/notes/note_dto.dart';

final class NoteRepository extends Repository<Note> with CrudRepositoryMixin<Note> {
  NoteRepository(super.store);
}
