import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/objectbox.g.dart';
import 'package:serealappv2/repository/common/database.dart';
import 'package:serealappv2/repository/common/repository.dart';
import 'package:serealappv2/repository/daily_logs/daily_log_dto.dart';
import 'package:serealappv2/utils/logging/sereal_logger.dart';

part 'daily_log_repository.g.dart';

final class DailyLogRepository extends Repository<DailyLogDto>
    with GetAllMixin, SaveObjectMixin, SerealLoggerMixin {
  DailyLogRepository(super.store);

  @override
  Future<List<DailyLogDto>> getAll() async {
    final records = await super.getAll();
    logInfo('Got records: $records');
    return records;
  }

  Future<List<DailyLogDto>> getBetweenDates(DateTime start, DateTime end) {
    return box
        .query(
          DailyLogDto_.date.betweenDate(
            start.toUtc(),
            end.toUtc(),
          ),
        )
        .build()
        .findAsync();
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

@riverpod
FutureOr<DailyLogRepository> dailyLogRepository(Ref ref) async {
  return DailyLogRepository(await ref.watch(getObjectBoxStoreProvider.future));
}
