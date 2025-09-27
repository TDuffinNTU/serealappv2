import 'package:serealappv2/objectbox.g.dart';
import 'package:serealappv2/repository/common/repository.dart';
import 'package:serealappv2/repository/daily_logs/daily_log_dto.dart';

final class DailyLogRepository extends Repository<DailyLog> with GetAllMixin<DailyLog> {
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
