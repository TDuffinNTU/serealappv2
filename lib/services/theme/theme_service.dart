import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/repository/theme/theme_dto.dart' as repo;
import 'package:serealappv2/repository/theme/theme_mapper.dart' as mapper;
import 'package:serealappv2/repository/theme/theme_repository.dart';
import 'package:serealappv2/services/theme/sereal_theme_model.dart';
import 'package:serealappv2/services/theme/sereal_theme_model_extensions.dart';
import 'package:serealappv2/utils/brightness_extensions.dart';

part 'theme_service.g.dart';

@riverpod
class ThemeService extends _$ThemeService {
  @override
  FutureOr<SerealTheme> build() async {
    final repository = await ref.read(getThemeRepositoryProvider.future);
    repo.SerealTheme? dto = await repository.getFirst();

    if (dto == null) {
      dto = mapper.toDto(
        SerealTheme(
          seedColor: kDefaultSeedColor,
          brightness: Brightness.light,
        ),
      );
      repository.put(dto);
    }

    return mapper.fromDto(dto);
  }

  Future<void> toggleBrightness() async {
    final repository = await ref.read(getThemeRepositoryProvider.future);
    final theme = await future;

    state = AsyncValue.data(theme.copyWith(brightness: theme.brightness.toggled));

    repository.put(mapper.toDto(theme));
  }

  Future<void> setSeedColor(Color color) async {
    final repository = await ref.read(getThemeRepositoryProvider.future);
    final theme = await future;

    state = AsyncValue.data(theme.copyWith(seedColor: color));

    repository.put(mapper.toDto(theme));
  }
}
