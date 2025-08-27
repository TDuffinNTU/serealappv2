import 'package:objectbox/objectbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/data/database.dart';

part 'repository.g.dart';

base class Repository<T> {
  Repository(this.store) : box = Box<T>(store);
  final Store store;
  final Box<T> box;
}

base mixin CrudRepositoryMixin<T> on Repository<T> {
  Future<void> delete(int id) {
    return box.removeAsync(id);
  }

  Future<List<T>> getAll() {
    return box.getAllAsync();
  }

  Future<T> save(T value) {
    return box.putAndGetAsync(value);
  }
}

@riverpod
Future<Repository<T>> getRepository<T>(Ref ref) async {
  return Repository<T>(await ref.read(getObjectBoxStoreProvider.future));
}
