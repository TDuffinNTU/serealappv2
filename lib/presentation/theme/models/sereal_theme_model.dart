import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serealappv2/services/theme/sereal_flex_theme.dart';

part 'sereal_theme_model.freezed.dart';

@freezed
class SerealTheme with _$SerealTheme {
  const SerealTheme({
    required this.color,
    required this.mode,
  });

  factory SerealTheme.defaultTheme() => const SerealTheme(
        color: SerealFlexTheme.defaultSeedColor,
        mode: ThemeMode.system,
      );

  @override
  final Color color;
  @override
  final ThemeMode mode;
}
