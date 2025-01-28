import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/utils/sereal_logger.dart';

part 'database_providers.g.dart';

MimirIndex? _database;

@riverpod
FutureOr<MimirIndex> getDatabase(Ref ref) async {
  var _instance = await Mimir.defaultInstance;
  if (_database == null) {
    _database = await _instance.openIndex('logs');
    SerealLogger.info(message: 'DB singleton initialised', name: 'Mimir');
  }
  return _database!;
}

@riverpod
Future<void> databaseDeleteRecord(Ref ref, {required DailyLog log}) async {
  (await ref.read(getDatabaseProvider.future)).deleteDocument(log.id);
  SerealLogger.info(message: 'Deleted record: ${log.id}', name: 'Mimir');
  ref.invalidate(getDatabaseProvider);
}

@riverpod
Future<void> databaseClearRecords(Ref ref) async {
  (await ref.read(getDatabaseProvider.future)).deleteAllDocuments();
  SerealLogger.info(message: 'Deleted all records!', name: 'Mimir');
  ref.invalidate(getDatabaseProvider);
}

@riverpod
Future<void> databaseAddRecord(Ref ref, {required DailyLog log}) async {
  (await ref.read(getDatabaseProvider.future)).addDocument(log.toJson());
  SerealLogger.info(message: 'Added/Updated record ${log.id}', name: 'Mimir');
  ref.invalidate(getDatabaseProvider);
}
