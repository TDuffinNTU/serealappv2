import 'package:flutter/material.dart';
import 'package:serealappv2/repository/theme/sereal_theme_dto.dart';
import 'package:serealappv2/services/theme/models/sereal_theme.dart';

final class SerealThemeMapper {
  static SerealTheme? toModel(SerealThemeDto? value) => value == null
      ? null
      : SerealTheme(
          color: Color(value.color),
          mode: ThemeMode.values[value.mode],
        );

  static SerealThemeDto toDto(SerealTheme value) => SerealThemeDto(
        color: value.color.toARGB32(),
        mode: value.mode.index,
      );
}
