import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/providers/database.dart';
import 'package:serealappv2/models/types/daily_log.dart';

part 'logs_collection.g.dart';

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
