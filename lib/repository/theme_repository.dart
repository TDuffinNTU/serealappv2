import 'package:serealappv2/domain/entities/theme.dart';
import 'package:serealappv2/repository/log_repository.dart';

class ThemeRepository extends BaseObjectstoreRepository<Theme> with SingletonCrudMixin<Theme> {
  ThemeRepository(super.store);

  Future<void> toggleBrightness() => get().then(
        (v) {
          v.isDark = !v.isDark;
          set(v);
        },
      );
}
