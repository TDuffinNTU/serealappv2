import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/datetime_extensions.dart';
import 'package:serealappv2/models/providers/database.dart';
import 'package:serealappv2/models/types/daily_log.dart';

part 'logs.g.dart';

@riverpod
class Logs extends _$Logs {
  Logs();

  late final MimirIndex _database;

  @override
  FutureOr<List<DailyLog>> build() async {
    _database = await ref.watch(getDatabaseProvider.future);
    return (await _database.getAllDocuments()).map(DailyLog.fromJson).toList();
  }

  /// Removes a log if it exists.
  Future<void> removeLog(DailyLog logToDelete) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // try to delete from db first.
      await _database.deleteDocument(logToDelete.date.asDatabaseKey());
      // update state.
      return [
        for (final element in state.value!)
          if (element.date.asDatabaseKey() != logToDelete.date.asDatabaseKey())
            element
      ];
    });
  }

  /// Updates a log or updates it.
  Future<void> createOrUpdateLog(DailyLog logToUpdate) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // try to update/add
      await _database.addDocument(logToUpdate.toJson());

      // add new element to state
      if (state.value!.any(
        (element) =>
            element.date.asDatabaseKey() == logToUpdate.date.asDatabaseKey(),
      )) {
        return [...state.value!, logToUpdate]..sort(
            (a, b) => a.date.compareTo(b.date),
          );
      }

      // update existing element in state
      return [
        for (final element in state.value!)
          if (element.date.asDatabaseKey() == logToUpdate.date.asDatabaseKey())
            logToUpdate
          else
            element
      ];
    });
  }
}
