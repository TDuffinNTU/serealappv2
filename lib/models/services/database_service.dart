import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/types/daily_log.dart';

part 'database_service.g.dart';

@riverpod
class DatabaseService extends _$DatabaseService {
  DatabaseService();

  late MimirInstance _instance;
  late MimirIndex _index;

  Future<Iterable<DailyLog>> _fetchAllRecords() async =>
      (await _index.search(sortBy: [SortBy.desc('date')]))
          .map(DailyLog.fromJson)
          .toList();

  FutureOr<Iterable<DailyLog>> build() async {
    _instance = await Mimir.defaultInstance;
    _index = await _instance.openIndex('logs');

    return _fetchAllRecords();
  }

  Future<void> clearAllRecords() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _index.deleteAllDocuments();
      return _fetchAllRecords();
    });
  }

  Future<void> upsertRecord(DailyLog log) async {
    state = await AsyncValue.guard(() async {
      await _index.addDocument(log.toJson());
      return _fetchAllRecords();
    });
  }

  Future<void> clearRecord(DailyLog log) async {
    state = await AsyncValue.guard(() async {
      await _index.deleteDocument(log.id);
      return _fetchAllRecords();
    });
  }
}
