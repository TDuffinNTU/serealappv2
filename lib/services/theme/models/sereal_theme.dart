import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serealappv2/utils/constants/theme_constants.dart';

part 'sereal_theme.freezed.dart';

@freezed
class SerealTheme with _$SerealTheme {
  const SerealTheme({
    required this.color,
    required this.mode,
  });

  factory SerealTheme.defaultTheme() => const SerealTheme(
        color: defaultSeedColor,
        mode: ThemeMode.system,
      );

  @override
  final Color color;

  @override
  final ThemeMode mode;
}
