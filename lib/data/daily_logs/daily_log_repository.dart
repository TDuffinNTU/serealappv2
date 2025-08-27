import 'package:serealappv2/data/common/repository.dart';
import 'package:serealappv2/data/daily_logs/daily_log_dto.dart';
import 'package:serealappv2/objectbox.g.dart';

final class DailyLogRepository extends Repository<DailyLog> with CrudRepositoryMixin<DailyLog> {
  DailyLogRepository(super.store);

  Future<DailyLog?> getForDate(DateTime date) {
    return box
        .query(
          DailyLog_.date.equalsDate(
            date.toUtc(),
          ),
        )
        .build()
        .findFirstAsync();
  }
}
