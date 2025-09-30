import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/repository/theme/theme_repository.dart';
import 'package:serealappv2/services/theme/models/sereal_theme.dart';
import 'package:serealappv2/services/theme/service/sereal_theme_mapper.dart';
import 'package:serealappv2/utils/logging/sereal_logger.dart';

part 'sereal_theme_service.g.dart';

@riverpod
class ThemeService extends _$ThemeService with SerealLoggerMixin {
  @override
  SerealTheme build() {
    logInfo('Init.');
    unawaited(loadFromDisk());
    return SerealTheme.defaultTheme();
  }

  Future<void> loadFromDisk() async {
    final repo = await ref.read(getThemeRepositoryProvider.future);
    final maybeTheme = await repo.getTheme();
    state = SerealThemeMapper.toModel(maybeTheme) ?? state;
    logInfo('Loaded from disk.');
  }

  Future<void> update(SerealTheme Function(SerealTheme old) mutate) async {
    final repo = await ref.read(getThemeRepositoryProvider.future);
    state = mutate(state);
    await repo.saveObject(SerealThemeMapper.toDto(state));
    logInfo('Updated state: $state');
  }
}
