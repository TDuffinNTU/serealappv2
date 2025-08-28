import 'package:objectbox/objectbox.dart';

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
