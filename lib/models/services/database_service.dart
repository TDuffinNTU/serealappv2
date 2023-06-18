import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_service.g.dart';

@riverpod
Future<MimirIndex> getDatabase(GetDatabaseRef ref) async {
  var instance = await Mimir.defaultInstance;
  return instance.openIndex('logs');
}
