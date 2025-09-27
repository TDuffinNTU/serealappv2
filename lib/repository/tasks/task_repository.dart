import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/repository/common/database.dart';
import 'package:serealappv2/repository/common/repository.dart';
import 'package:serealappv2/repository/tasks/task_dto.dart';

part 'task_repository.g.dart';

final class TaskRepository extends Repository<Task> with GetAllMixin<Task> {
  TaskRepository(super.store);
}

@riverpod
Future<TaskRepository> getThemeRepository(Ref ref) async {
  return TaskRepository(await ref.read(getObjectBoxStoreProvider.future));
}
