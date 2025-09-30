import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log_filter.dart';

part 'notes_tab_controller.g.dart';

class NotesTabControllerState {
  NotesTabControllerState({required this.filter});

  final DailyLogFilter filter;
}

@riverpod
class NotesTabController extends _$NotesTabController
    with ScreenControllerMixin {
  @override
  NotesTabControllerState build() {
    return NotesTabControllerState(filter: const AllLogsFilter());
  }
}

mixin ScreenControllerMixin<T> on $Notifier<T> {
  void mutate(T Function(T old) mutator) {
    state = mutator(state);
  }
}
