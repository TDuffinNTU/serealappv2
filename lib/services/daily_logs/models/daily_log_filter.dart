import 'package:serealappv2/services/daily_logs/models/daily_log.dart';

/// Sealed class of different forms of filters that can be applied to
/// the daily logs service.
sealed class DailyLogFilter {
  const DailyLogFilter();
}

// TODOpaginate?
class AllLogsFilter extends DailyLogFilter {
  const AllLogsFilter();
}

class BetweenDatesFilter extends DailyLogFilter {
  BetweenDatesFilter({
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;
}

class ContainsNoteFilter extends DailyLogFilter {
  ContainsNoteFilter({required this.guid});

  /// Guid for a particular [Note].
  final String guid;
}
