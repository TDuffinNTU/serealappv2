import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/objectbox.g.dart';

part 'database.g.dart';

@Riverpod(keepAlive: true)
Future<Store> getObjectBoxStore(Ref ref) async {
    final dir = await getApplicationDocumentsDirectory();
  final store = await openStore(directory: p.join(dir.path, 'sereal_db'));
  return store;
}
