import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/providers/database_providers.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';
import 'package:serealappv2/utils/sereal_logger.dart';

part 'log_providers.g.dart';

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

/// Returns the stored log for a given date,
/// or a new log with the given date if none exists.
@riverpod
Future<DailyLog> getLog(GetLogRef ref, DateTime date) async {
  final List<DailyLog> logs = await ref.watch(
    filteredLogsProvider(
      filter: Mimir.where(
        'date',
        isEqualTo: date.databaseType,
      ),
    ).future,
  );

  if (logs.isEmpty) {
    DailyLog newLog = DailyLog.defaults(date: date);
    SerealLogger.info(message: 'Creating new log: ${newLog.id}', name: 'LogProviders');
    return newLog;
  } else {
    DailyLog fetchedLog = logs.first;
    SerealLogger.info(message: 'Found log: ${fetchedLog.id}', name: 'LogProviders');
    return fetchedLog;
  }
}
