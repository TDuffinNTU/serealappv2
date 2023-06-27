import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/providers/database_providers.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';

part 'log_providers.g.dart';

@riverpod
class LogsCollection extends _$LogsCollection {
  LogsCollection();

  late MimirIndex _database;

  Future<void> deleteLog(DailyLog log) async {
    await _database.deleteDocument(log.id);
    state = await AsyncValue.guard(() async {
      return _fetchLogs();
    });
  }

  Future<void> saveLog(DailyLog log) async {
    await _database.addDocument(log.toJson());
    state = await AsyncValue.guard(() async {
      return _fetchLogs();
    });
  }

  Future<void> deleteAllLogs() async {
    await _database.deleteAllDocuments();
    state = await AsyncValue.guard(() async {
      return _fetchLogs();
    });
  }

  Future<List<DailyLog>> _fetchLogs() async {
    return (await _database.getAllDocuments()).map(DailyLog.fromJson).toList();
  }

  @override
  FutureOr<List<DailyLog>> build() async {
    _database = await ref.watch(getDatabaseProvider.future);
    return _fetchLogs();
  }
}

/// Returns the result of a MimirIndex.search using the filters provided.
///
/// A `null` filter will return *all* the logs in the db.
///
/// A search may return no results, in which case an empty List<DailyLog>
/// will be returned.
@riverpod
Future<List<DailyLog>> filteredLogs(FilteredLogsRef ref, {required Filter? filter}) async {
  final MimirIndex db = await ref.watch(getDatabaseProvider.future);
  final List<MimirDocument> documents = await db.search(filter: filter);

  return documents.map(DailyLog.fromJson).toList();
}

/// Returns the stored log for today,
/// or a new log with today's date if none exists.
@riverpod
Future<DailyLog> todayLog(TodayLogRef ref) async {
  final DateTime today = DateTime.now();

  final List<DailyLog> logs = await ref.watch(
    filteredLogsProvider(
      filter: Mimir.where(
        'date',
        isEqualTo: today.databaseType,
      ),
    ).future,
  );

  return logs.isNotEmpty ? logs.first : DailyLog.defaults();
}

/// Returns the stored log for tomorrow,
/// or a new log with tomorrows date if none exists.
@riverpod
Future<DailyLog> tomorrowLog(TomorrowLogRef ref) async {
  final DateTime tomorrow = DateTime.now().dateOnly.add(Duration(days: 1));

  final List<DailyLog> logs = await ref.watch(
    filteredLogsProvider(
      filter: Mimir.where(
        'date',
        isEqualTo: tomorrow.databaseType,
      ),
    ).future,
  );

  return logs.isNotEmpty ? logs.first : DailyLog.defaults(date: tomorrow);
}

/// Returns the stored log for yesterday,
/// or a new log with yesterdays date if none exists.
@riverpod
Future<DailyLog> yesterdayLog(YesterdayLogRef ref) async {
  final DateTime yesterday = DateTime.now().dateOnly.subtract(Duration(days: 1));

  final List<DailyLog> logs = await ref.watch(
    filteredLogsProvider(
      filter: Mimir.where(
        'date',
        isEqualTo: yesterday.databaseType,
      ),
    ).future,
  );

  return logs.isNotEmpty ? logs.first : DailyLog.defaults(date: yesterday);
}
