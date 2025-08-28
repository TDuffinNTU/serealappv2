import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sereal_theme_model.freezed.dart';

@freezed
class SerealTheme with _$SerealTheme {
  const SerealTheme({
    required this.seedColor,
    required this.brightness,
  });

  final Color seedColor;
  final Brightness brightness;
}
