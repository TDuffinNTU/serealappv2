import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/services/data/database_service.dart';
import 'package:serealappv2/models/services/tabs/base_tab_service.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';

part 'home_tab_service.g.dart';

@riverpod
class HomeTabService extends _$HomeTabService implements BaseTabService {
  HomeTabService();

  late MimirIndex _database;

  @override
  Future<void> deleteLog(DailyLog log) async {
    state = await AsyncValue.guard(() async {
      await _database.deleteDocument(log.id);
      return _fetchLogs();
    });
  }

  @override
  Future<void> saveLog(DailyLog log) async {
    state = await AsyncValue.guard(() async {
      await _database.addDocument(log.toJson());
      return _fetchLogs();
    });
  }

  Future<List<DailyLog>> _fetchLogs() async {
    DateTime yesterday = DateTime.now().dateOnly.subtract(Duration(days: 1));

    DateTime tomorrow = DateTime.now().dateOnly.add(Duration(days: 1));

    var logs = (await _database.search(
      filter: Mimir.where(
        'date',
        containsAtLeastOneOf: [
          yesterday.databaseType,
          DateTime.now().databaseType,
          tomorrow.databaseType,
        ],
      ),
    ))
        .map(DailyLog.fromJson)
        .toList();

    List<DailyLog> results = [];

    // Add yesterday
    results.add(
      logs.firstWhere(
        (log) => log.date == yesterday,
        orElse: () => DailyLog.defaults(
          date: yesterday,
        ),
      ),
    );

    // Add today
    results.add(
      logs.firstWhere(
        (log) => log.date == DateTime.now().dateOnly,
        orElse: () => DailyLog.defaults(),
      ),
    );

    // Add tomorrow
    results.add(
      logs.firstWhere(
        (log) => log.date == tomorrow,
        orElse: () => DailyLog.defaults(
          date: tomorrow,
        ),
      ),
    );

    return results;
  }

  @override
  FutureOr<List<DailyLog>> build() async {
    _database = await ref.watch(getDatabaseProvider.future);

    return _fetchLogs();
  }
}
