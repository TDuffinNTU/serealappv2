import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/providers/logs_collection.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';

part 'home_screen_logs.g.dart';

@riverpod
Future<List<DailyLog>> getHomeScreenLogs(GetHomeScreenLogsRef ref) async {
  List<DailyLog> allLogs = await ref.watch(logsCollectionProvider.future);

  final DateTime yesterday = DateTime.now().dateOnly.subtract(Duration(days: 1));
  final DateTime tomorrow = DateTime.now().dateOnly.add(Duration(days: 1));

  List<DailyLog> filteredLogs = [];

  // Add yesterday
  filteredLogs.add(
    allLogs.firstWhere(
      (log) => log.date == yesterday,
      orElse: () => DailyLog.defaults(
        date: yesterday,
      ),
    ),
  );

  // Add today
  filteredLogs.add(
    allLogs.firstWhere(
      (log) => log.date == DateTime.now().dateOnly,
      orElse: () => DailyLog.defaults(),
    ),
  );
// Add tomorrow
  filteredLogs.add(
    allLogs.firstWhere(
      (log) => log.date == tomorrow,
      orElse: () => DailyLog.defaults(
        date: tomorrow,
      ),
    ),
  );
  return filteredLogs;
}
