import 'package:objectbox/objectbox.dart';

base class Repository<T> {
  Repository(this.store) : box = Box<T>(store);
  final Store store;
  final Box<T> box;
}

base mixin DeleteMixin<T> on Repository<T> {
  Future<void> delete(T obj);
}

base mixin GetAllMixin<T> on Repository<T> {
  Future<List<T>> getAll() async {
    return await box.getAllAsync();
  }
}

base mixin GetByIdMixin<T> on Repository<T> {
  Future<T?> getById(int id) async {
    return await box.getAsync(id);
  }
}

base mixin SaveObjectMixin<T> on Repository<T> {
  Future<void> saveObject(T obj) async {
    await box.putAsync(obj);
  }
}
