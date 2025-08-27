import 'package:serealappv2/data/common/repository.dart';
import 'package:serealappv2/data/tasks/task_dto.dart';

final class TaskRepository extends Repository<Task> with CrudRepositoryMixin<Task> {
  TaskRepository(super.store);
}
