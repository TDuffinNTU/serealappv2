import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/repository/common/repository.dart';
import 'package:serealappv2/repository/common/database.dart';
import 'package:serealappv2/repository/theme/sereal_theme_dto.dart';
import 'package:serealappv2/utils/sereal_logger.dart';

part 'theme_repository.g.dart';

final class ThemeRepository extends Repository<SerealThemeDto>
    with SaveObjectMixin, SerealLoggerMixin {
  ThemeRepository(super.store);

  Future<SerealThemeDto?> getTheme() async {
    final record = (await box.getAllAsync()).firstOrNull;
    logInfo('Search response: $record');
    return record;
  }

  @override
  Future<void> saveObject(SerealThemeDto obj) async {
    obj.id = (await getTheme())?.id ?? 0;
    logInfo('Storing obj: $obj');
    return super.saveObject(obj);
  }
}

@riverpod
Future<ThemeRepository> getThemeRepository(Ref ref) async {
  return ThemeRepository(await ref.read(getObjectBoxStoreProvider.future));
}
