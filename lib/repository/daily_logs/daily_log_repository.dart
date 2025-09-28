import 'package:serealappv2/objectbox.g.dart';
import 'package:serealappv2/repository/common/repository.dart';
import 'package:serealappv2/repository/daily_logs/daily_log_dto.dart';
import 'package:serealappv2/utils/logging/sereal_logger.dart';

final class DailyLogRepository extends Repository<DailyLogDto>
    with GetAllMixin, SaveObjectMixin, SerealLoggerMixin {
  DailyLogRepository(super.store);

  Future<DailyLogDto?> getForDate(DateTime date) {
    return box
        .query(
          DailyLogDto_.date.equalsDate(
            date.toUtc(),
          ),
        )
        .build()
        .findFirstAsync();
  }

  @override
  Future<void> saveObject(DailyLogDto obj) async {
    final record = await box
        .query(
          DailyLogDto_.guid.equals(obj.guid),
        )
        .build()
        .findFirstAsync();

    obj.id = record?.id ?? 0;
    logInfo('Storing obj: $obj');

    return super.saveObject(obj);
  }
}
