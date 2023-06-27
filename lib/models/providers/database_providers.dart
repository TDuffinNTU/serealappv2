import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/types/daily_log.dart';

part 'database_providers.g.dart';

@riverpod
FutureOr<MimirIndex> getDatabase(GetDatabaseRef ref) async {
  var _instance = await Mimir.defaultInstance;
  return _instance.openIndex('logs');
}

@riverpod
Future<void> databaseDeleteRecord(DatabaseDeleteRecordRef ref, {required DailyLog log}) async {
  (await ref.read(getDatabaseProvider.future)).deleteDocument(log.id);
  ref.invalidate(getDatabaseProvider);
}

@riverpod
Future<void> databaseClearRecords(DatabaseClearRecordsRef ref) async {
  (await ref.read(getDatabaseProvider.future)).deleteAllDocuments();
  ref.invalidate(getDatabaseProvider);
}

@riverpod
Future<void> databaseAddRecord(DatabaseAddRecordRef ref, {required DailyLog log}) async {
  (await ref.read(getDatabaseProvider.future)).addDocument(log.toJson());
  // Don't invalidate database for writes -- unnecessary?
}
