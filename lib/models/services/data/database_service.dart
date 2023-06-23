import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/models/services/tabs/home_tab_service.dart';

part 'database_service.g.dart';

@riverpod
FutureOr<MimirIndex> getDatabase(GetDatabaseRef ref) async {
  var _instance = await Mimir.defaultInstance;
  ref.invalidate(homeTabServiceProvider);

  return _instance.openIndex('logs');
}
