import 'package:serealappv2/domain/entities/log.dart';
import 'package:serealappv2/objectbox.g.dart';

mixin CrudMixin<T> on BaseObjectstoreRepository<T> {
  Future<List<T>> getAll() => _box.getAllAsync();
  Future<void> save(T value);
}

mixin SingletonCrudMixin<T> on BaseObjectstoreRepository<T> {
  Future<T> get() => _box.getAllAsync().then((v) => v.first);
  Future<void> set(T value) => _box.removeAllAsync().then((_) => _box.putAsync(value));
}

abstract class BaseObjectstoreRepository<T> {
  final Store _store;
  late final Box<T> _box;

  BaseObjectstoreRepository(this._store) {
    _box = _store.box<T>();
  }
}

class LogRepository extends BaseObjectstoreRepository<Log> with CrudMixin<Log> {
  LogRepository(super.store);

  Future<List<Log>> getAll() => _box.getAllAsync();

  Future<void> save(Log log) => _box.putAsync(log);

  Future<Log> getForDate(DateTime date) async {
    Log? maybeLog = await _box.query(Log_.date.equalsDate(date.toUtc())).build().findFirstAsync();
    return maybeLog ?? Log(date: date.toUtc());
  }
}
