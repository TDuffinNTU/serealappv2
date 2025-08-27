import 'package:serealappv2/data/common/repository.dart';
import 'package:serealappv2/data/theme/theme_dto.dart';

base class ThemeRepository extends Repository<Theme> {
  ThemeRepository(super.store);

  Future<Theme?> getFirst() async {
    final maybeTheme = await box.getAllAsync();
    return maybeTheme.firstOrNull;
  }

  Future<void> put(Theme value) {
    value.id = 1;
    return box.putAsync(value);
  }
}
