import 'package:serealappv2/models/types/daily_log.dart';

/// Common functionality for home screen tabs for manipulating logs.
abstract class BaseTabService {
  Future<void> saveLog(DailyLog log);
  Future<void> deleteLog(DailyLog log);
}
