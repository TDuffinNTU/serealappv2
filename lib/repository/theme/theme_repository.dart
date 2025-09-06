import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/repository/common/repository.dart';
import 'package:serealappv2/repository/common/database.dart';
import 'package:serealappv2/repository/theme/theme_dto.dart';

part 'theme_repository.g.dart';

base class ThemeRepository extends Repository<SerealTheme> {
  ThemeRepository(super.store);

  Future<SerealTheme?> getFirst() async {
    final maybeTheme = await box.getAllAsync();
    return maybeTheme.firstOrNull;
  }

  Future<void> put(SerealTheme value) {
    return box.putAsync(value);
  }
}

@riverpod
Future<ThemeRepository> getThemeRepository(Ref ref) async {
  return ThemeRepository(await ref.read(getObjectBoxStoreProvider.future));
}
