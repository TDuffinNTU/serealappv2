import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/repository/daily_logs/daily_log_repository.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log_filter.dart';
import 'package:serealappv2/services/daily_logs/service/daily_logs_mapper.dart';

part 'daily_logs_service.g.dart';

@riverpod
class DailyLogsService extends _$DailyLogsService {
  @override
  FutureOr<List<DailyLog>> build({
    DailyLogFilter filter = const AllLogsFilter(),
  }) async {
    final repo = await ref.watch(dailyLogRepositoryProvider.future);

    return listMapper(
      switch (filter) {
        AllLogsFilter() => await repo.getAll(),
        ContainsNoteFilter() => await repo.getAll(),
        BetweenDatesFilter() => await repo.getBetweenDates(
            filter.start,
            filter.end,
          ),
      },
      DailyLogsMapper.toModel,
    );
  }

  Future<void> deleteAll() async {
    final repo = await ref.read(dailyLogRepositoryProvider.future);
    return repo.deleteAll();
  }
}
