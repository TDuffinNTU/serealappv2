import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log.dart';
import 'package:serealappv2/services/daily_logs/service/daily_logs_service.dart';

part 'notes_tab_controller.g.dart';

@riverpod
class NotesTabController extends _$NotesTabController {
  @override
  Future<List<DailyLog>> build() async {
    final dailyLogs = await ref.watch(dailyLogsServiceProvider().future);

    return dailyLogs;
  }

  Future<void> deleteAll() async {
    await ref.read(dailyLogsServiceProvider().notifier).deleteAll();
  }
}
