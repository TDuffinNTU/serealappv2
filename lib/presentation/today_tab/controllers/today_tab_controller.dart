import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log_filter.dart';
import 'package:serealappv2/services/daily_logs/service/daily_logs_service.dart';
import 'package:serealappv2/utils/extensions/datetime_extensions.dart';

part 'today_tab_controller.g.dart';

@riverpod
class TodayTabController extends _$TodayTabController {
  @override
  Future<List<DailyLog>> build() async {
    final filter = BetweenDatesFilter(start: yesterday, end: tomorrow);
    final dailyLogs =
        await ref.watch(dailyLogsServiceProvider(filter: filter).future);

    for (final date in [yesterday, today, tomorrow]) {
      if (!dailyLogs.any((e) => e.date == date)) {
        dailyLogs.add(DailyLog.defaults(date: date));
      }
    }

    return dailyLogs;
  }
}
