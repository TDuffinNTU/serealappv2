import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/types/daily_log.dart';

part 'database.g.dart';

@riverpod
class Database extends _$Database {
  Database();

  @override
  FutureOr<List<DailyLog>> build() async {
    database = await Mimir.defaultInstance;
    index = await database.openIndex('logs', primaryKey: 'date');

    return index
        .getAllDocuments()
        .then((list) => list.map((e) => DailyLog.fromJson(e)).toList());
  }

  /// Removes a log if it exists.
  Future<void> removeLog(String id) async {
    await index.deleteDocument(id);
  }

  /// Updates a log or updates it.
  Future<void> createOrUpdateLog(DailyLog log) async {
    await index.addDocument(log.toJson());
  }

  late final MimirInstance database;
  late final MimirIndex index;
  late final List<DailyLog> dailyLogs;
}
