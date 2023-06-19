import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/datetime_extensions.dart';
import 'package:serealappv2/models/services/database_service.dart';
import 'package:serealappv2/models/types/daily_log.dart';

part 'logs_service.g.dart';

@riverpod
class LogsService extends _$LogsService {
  LogsService();

  late MimirIndex _database;

  /// Index of today's date. null if loading.
  int? get todayIndex => state.asData?.valueOrNull
      ?.indexWhere((element) => element.date == DateTime.now().dateOnly);

  /// Length of state array. -1 if loading.
  int get length => state.hasValue ? state.value!.length : -1;

  /// Returns whether a date is present in the db.
  Future<bool> _recordAtDate(DateTime date) async => (await _database.search(
          filter:
              Mimir.where('date', isEqualTo: date.dateOnly.toIso8601String())))
      .isNotEmpty;

  Future<List<DailyLog>> _fetchLogs() async {
    // add a new log if none is available
    if (!await _recordAtDate(DateTime.now())) {
      await _database.addDocument(DailyLog.defaults().toJson());
    }

    // add a new log if none is available for tomorrow
    if (!await _recordAtDate(DateTimeExtensions.tomorrow())) {
      await _database.addDocument(
          DailyLog.defaults(date: DateTimeExtensions.tomorrow()).toJson());
    }

    // sort by date and return
    var records = (await _database.search(
      sortBy: [
        SortBy.asc('date'),
      ],
    ))
        .map(DailyLog.fromJson)
        .toList();

    return records;
  }

  @override
  FutureOr<List<DailyLog>> build() async {
    _database = await ref.watch(getDatabaseProvider.future);

    return _fetchLogs();
  }

  /// Removes a log if it exists.
  Future<void> removeLog(DailyLog logToDelete) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // try to delete from db first.
      await _database.deleteDocument(logToDelete.id);
      // update state.
      return [
        for (final element in state.value!)
          if (element.id != logToDelete.id) element
      ];
    });
  }

  /// Updates a log or updates it.
  Future<void> createOrUpdateLog(DailyLog logToUpdate) async {
    //state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // try to update/add
      await _database.addDocument(logToUpdate.toJson());

      if ((await _database.search(
              filter: Mimir.where('id', isEqualTo: logToUpdate.id)))
          .isEmpty) {
        // update existing element in state
        return [
          for (final element in state.value!)
            if (element.id == logToUpdate.id) logToUpdate else element
        ];
      }

      // add new element to state
      return [...state.value!, logToUpdate]..sort(
          (a, b) => a.date.compareTo(b.date),
        );
    });
  }

  /// Deletes all the logs, and then re-inits the db.
  Future<void> clearAllLogs() async {
    state = await AsyncValue.guard(() async {
      await _database.deleteAllDocuments();
      return _fetchLogs();
    });
  }
}
