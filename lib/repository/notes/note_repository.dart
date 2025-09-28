import 'package:serealappv2/repository/common/repository.dart';
import 'package:serealappv2/repository/notes/note_dto.dart';

final class NoteRepository extends Repository<NoteDto>
    with GetAllMixin<NoteDto> {
  NoteRepository(super.store);
}
