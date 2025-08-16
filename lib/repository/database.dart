import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:serealappv2/objectbox.g.dart';

part 'database.g.dart';

@riverpod
class Database extends _$Database {
  @override
  Future<ObjectboxStore> build() async => await ObjectboxStore()
    ..create();
}

class ObjectboxStore {
  late final Store store;

  Future<void> create() async {
    final dir = await getApplicationDocumentsDirectory();
    store = await openStore(directory: p.join(dir.path, 'todo_notes_db'));
  }
}
