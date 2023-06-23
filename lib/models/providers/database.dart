import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/types/daily_log.dart';

part 'database.g.dart';

@riverpod
FutureOr<MimirIndex> getDatabase(GetDatabaseRef ref) async {
  var _instance = await Mimir.defaultInstance;
  return _instance.openIndex('logs');
}

@riverpod
Future<void> deleteRecord(DeleteRecordRef ref, {required DailyLog log}) async {
  (await ref.read(getDatabaseProvider.future)).deleteDocument(log.id);
  ref.invalidate(getDatabaseProvider);
}

@riverpod
Future<void> deleteAllRecords(DeleteAllRecordsRef ref) async {
  (await ref.read(getDatabaseProvider.future)).deleteAllDocuments();
  ref.invalidate(getDatabaseProvider);
}
