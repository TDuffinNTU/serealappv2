import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:serealappv2/objectbox.g.dart';

part 'database.g.dart';

Store? _store;

@riverpod
Future<Store> getObjectBoxStore(Ref ref) async {
  Store? maybeStore = _store;
  if (maybeStore == null) {
    final dir = await getApplicationDocumentsDirectory();
    maybeStore = await openStore(directory: p.join(dir.path, 'todo_notes_db'));
    _store = maybeStore;
  }
  return maybeStore;
}
